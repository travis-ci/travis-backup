# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'models/repository'
require 'models/log'
require 'models/branch'
require 'models/tag'
require 'models/commit'
require 'models/cron'
require 'models/pull_request'
require 'models/ssl_key'
require 'models/request'
require 'models/stage'

# main travis-backup class
class Backup
  attr_accessor :config
  attr_reader :dry_run_report

  def initialize(config_args={})
    @config = Config.new(config_args)

    if @config.dry_run
      @dry_run_report = {builds: [], jobs: [], logs: [], requests: []}
    end

    connect_db
  end

  def connect_db(url=@config.database_url)
    ActiveRecord::Base.establish_connection(url)
  end

  def run(args={})
    user_id = args[:user_id] || @config.user_id
    repo_id = args[:repo_id] || @config.repo_id
    org_id = args[:org_id] || @config.org_id

    if @config.move_logs
      move_logs
    elsif @config.remove_orphans
      remove_orphans
    elsif user_id
      process_user(user_id)
    elsif org_id
      process_organization(org_id)
    elsif repo_id
      process_repo_with_id(repo_id)
    else
      process_all_repos
    end

    print_dry_run_report if @config.dry_run
  end

  def process_user(user_id)
    if @config.threshold
      process_repos_for_owner(user_id, 'User')
    else
      remove_user_with_dependencies(user_id)
    end
  end

  def process_organization(org_id)
    if @config.threshold
      process_repos_for_owner(org_id, 'Organization')
    else
      remove_org_with_dependencies(org_id)
    end
  end

  def process_repos_for_owner(owner_id, owner_type)
    Repository.where('owner_id = ? and owner_type = ?', owner_id, owner_type).order(:id).each do |repository|
      process_repo(repository)
    end
  end

  def process_repo_with_id(repo_id)
    if @config.threshold
      process_repo(Repository.find(repo_id))
    else
      remove_repo_with_dependencies(repo_id)
    end
  end

  def remove_repo_with_dependencies(repo_id)
    
  end

  def process_all_repos
    Repository.order(:id).each do |repository|
      process_repo(repository)
    end
  end

  def print_dry_run_report
    if @dry_run_report.to_a.map(&:second).flatten.empty?
      puts 'Dry run active. No data would be removed in normal run.'
    else
      puts 'Dry run active. The following data would be removed in normal run:'

      @dry_run_report.to_a.map(&:first).each do |symbol|
        print_dry_run_report_line(symbol)
      end
    end
  end

  def print_dry_run_report_line(symbol)
    puts " - #{symbol}: #{@dry_run_report[symbol].to_json}" if @dry_run_report[symbol].any?
  end

  def process_repo(repository)
    process_repo_builds(repository)
    process_repo_requests(repository)
  end

  def process_repo_builds(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    threshold = @config.threshold.to_i.months.ago.to_datetime
    current_build_id = repository.current_build_id || -1
    repository.builds.where('created_at < ? and id != ?', threshold, current_build_id)
              .in_groups_of(@config.limit.to_i, false).map do |builds_batch|
      @config.if_backup ? save_and_destroy_builds_batch(builds_batch, repository) : destroy_builds_batch(builds_batch)
    end.compact
  end

  def process_repo_requests(repository)
    threshold = @config.threshold.to_i.months.ago.to_datetime
    repository.requests.where('created_at < ?', threshold)
              .in_groups_of(@config.limit.to_i, false).map do |requests_batch|
      @config.if_backup ? save_and_destroy_requests_batch(requests_batch, repository) : destroy_requests_batch(requests_batch)
    end.compact
  end

  def move_logs
    return move_logs_dry if config.dry_run

    connect_db(@config.database_url)
    Log.order(:id).in_groups_of(@config.limit.to_i, false).map do |logs_batch|
      log_hashes = logs_batch.as_json
      connect_db(@config.destination_db_url)

      log_hashes.each do |log_hash|
        new_log = Log.new(log_hash)
        new_log.save!
      end

      connect_db(@config.database_url)

      logs_batch.each(&:destroy)
    end
  end

  def move_logs_dry
    dry_run_report[:logs].concat(Log.order(:id).map(&:id))
  end

  def remove_orphans
    cases = [
      {
        main_model: Repository,
        relations: [
          {related_model: Build, fk_name: 'current_build_id'},
          {related_model: Build, fk_name: 'last_build_id'}
        ]
      }, {
        main_model: Build,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'},
          {related_model: Commit, fk_name: 'commit_id'},
          {related_model: Request, fk_name: 'request_id'},
          {related_model: PullRequest, fk_name: 'pull_request_id'},
          {related_model: Branch, fk_name: 'branch_id'},
          {related_model: Tag, fk_name: 'tag_id'}
        ],
        method: :destroy_all,
        dry_run_complement: -> (ids) { add_builds_dependencies_to_dry_run_report(ids) }
      }, {
        main_model: Job,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'},
          {related_model: Commit, fk_name: 'commit_id'},
          {related_model: Stage, fk_name: 'stage_id'},
        ]
      }, {
        main_model: Branch,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'},
          {related_model: Build, fk_name: 'last_build_id'}
        ]
      }, {
        main_model: Tag,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'},
          {related_model: Build, fk_name: 'last_build_id'}
        ]
      }, {
        main_model: Commit,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'},
          {related_model: Branch, fk_name: 'branch_id'},
          {related_model: Tag, fk_name: 'tag_id'}
        ]
      }, {
        main_model: Cron,
        relations: [
          {related_model: Branch, fk_name: 'branch_id'}
        ]
      }, {
        main_model: PullRequest,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'}
        ]
      }, {
        main_model: SslKey,
        relations: [
          {related_model: Repository, fk_name: 'repository_id'}
        ]
      }, {
        main_model: Request,
        relations: [
          {related_model: Commit, fk_name: 'commit_id'},
          {related_model: PullRequest, fk_name: 'pull_request_id'},
          {related_model: Branch, fk_name: 'branch_id'},
          {related_model: Tag, fk_name: 'tag_id'}
        ]
      }, {
        main_model: Stage,
        relations: [
          {related_model: Build, fk_name: 'build_id'}
        ]
      }
    ]

    cases.each do |model_block|
      model_block[:relations].each do |relation|
        remove_orphans_for_table(
          main_model: model_block[:main_model],
          related_model: relation[:related_model],
          fk_name: relation[:fk_name],
          method: model_block[:method],
          dry_run_complement: model_block[:dry_run_complement]
        )
      end
    end
  end

  def add_builds_dependencies_to_dry_run_report(ids_for_delete)
    repos_for_delete = Repository.where(current_build_id: ids_for_delete)
    jobs_for_delete = Job.where(source_id: ids_for_delete)
    dry_run_report[:repositories].concat(repos_for_delete.map(&:id))
    dry_run_report[:jobs].concat(jobs_for_delete.map(&:id))
  end

  def remove_orphans_for_table(args)
    main_model = args[:main_model]
    related_model = args[:related_model]
    fk_name = args[:fk_name]
    method = args[:method] || :delete_all
    dry_run_complement = args[:dry_run_complement]

    main_table = main_model.table_name
    related_table = related_model.table_name

    for_delete = main_model.find_by_sql(%{
      select a.*
      from #{main_table} a
      left join #{related_table} b
      on a.#{fk_name} = b.id
      where
        a.#{fk_name} is not null
        and b.id is null;
    })

    ids_for_delete = for_delete.map(&:id)

    if config.dry_run
      key = main_table.to_sym

      dry_run_report[key] = [] if dry_run_report[key].nil?
      dry_run_report[key].concat(ids_for_delete)
      dry_run_report[key].uniq!

      dry_run_complement.call(ids_for_delete) if dry_run_complement
    else
      main_model.where(id: ids_for_delete).send(method)
    end
  end

  private

  def save_and_destroy_builds_batch(builds_batch, repository)
    builds_export = export_builds(builds_batch)
    file_name = "repository_#{repository.id}_builds_#{builds_batch.first.id}-#{builds_batch.last.id}.json"
    pretty_json = JSON.pretty_generate(builds_export)
    if save_file(file_name, pretty_json)
      destroy_builds_batch(builds_batch)
    end
    builds_export
  end

  def destroy_builds_batch(builds_batch)
    return destroy_builds_batch_dry(builds_batch) if @config.dry_run

    builds_batch.each(&:destroy)
  end

  def destroy_builds_batch_dry(builds_batch)
    @dry_run_report[:builds].concat(builds_batch.map(&:id))

    jobs = builds_batch.map do |build|
      build.jobs.map(&:id) || []
    end.flatten

    @dry_run_report[:jobs].concat(jobs)

    logs = builds_batch.map do |build|
      build.jobs.map do |job|
        job.logs.map(&:id) || []
      end.flatten || []
    end.flatten

    @dry_run_report[:logs].concat(logs)
  end

  def save_and_destroy_requests_batch(requests_batch, repository)
    requests_export = export_requests(requests_batch)
    file_name = "repository_#{repository.id}_requests_#{requests_batch.first.id}-#{requests_batch.last.id}.json"
    pretty_json = JSON.pretty_generate(requests_export)
    if save_file(file_name, pretty_json)
      destroy_requests_batch(requests_batch)
    end
    requests_export
  end

  def destroy_requests_batch(requests_batch)
    return destroy_requests_batch_dry(requests_batch) if @config.dry_run

    requests_batch.each(&:destroy)
  end

  def destroy_requests_batch_dry(requests_batch)
    @dry_run_report[:requests].concat(requests_batch.map(&:id))
  end

  def save_file(file_name, content) # rubocop:disable Metrics/MethodLength
    return true if @config.dry_run

    saved = false
    begin
      unless File.directory?(@config.files_location)
        FileUtils.mkdir_p(@config.files_location)
      end

      File.open(file_path(file_name), 'w') do |file|
        file.write(content)
        file.close
        saved = true
      end
    rescue => e
      print "Failed to save #{file_name}, error: #{e.inspect}\n"
    end
    saved
  end

  def file_path(file_name)
    "#{@config.files_location}/#{file_name}"
  end

  def export_builds(builds)
    builds.map do |build|
      build_export = build.attributes
      build_export[:jobs] = export_jobs(build.jobs)

      build_export
    end
  end

  def export_jobs(jobs)
    jobs.map do |job|
      job_export = job.attributes
      job_export[:logs] = export_logs(job.logs)

      job_export
    end
  end

  def export_logs(logs)
    logs.map do |log|
      log.attributes
    end
  end

  def export_requests(requests)
    requests.map do |request|
      request.attributes
    end
  end
end
