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

    if user_id
      owner_id = user_id
      owner_type = 'User'
    elsif org_id
      owner_id = org_id
      owner_type = 'Organization'
    end

    if @config.move_logs
      move_logs
    elsif @config.remove_orphans
      remove_orphans
    elsif owner_id
      process_repos_for_owner(owner_id, owner_type)
    elsif repo_id
      process_repo_with_id(repo_id)
    else
      process_all_repos
    end

    print_dry_run_report if @config.dry_run
  end

  def process_repos_for_owner(owner_id, owner_type)
    Repository.where('owner_id = ? and owner_type = ?', owner_id, owner_type).order(:id).each do |repository|
      process_repo(repository)
    end
  end

  def process_repo_with_id(repo_id)
    process_repo(Repository.find(repo_id))
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
    remove_orphans_for_table(Repository, 'repositories', 'builds', 'current_build_id')
    remove_orphans_for_table(Repository, 'repositories', 'builds', 'last_build_id')
    remove_orphans_for_table(Build, 'builds', 'repositories', 'repository_id')
    remove_orphans_for_table(Build, 'builds', 'commits', 'commit_id')
    remove_orphans_for_table(Build, 'builds', 'requests', 'request_id')
    remove_orphans_for_table(Build, 'builds', 'pull_requests', 'pull_request_id')
    remove_orphans_for_table(Build, 'builds', 'branches', 'branch_id')
    remove_orphans_for_table(Build, 'builds', 'tags', 'tag_id')
    remove_orphans_for_table(Job, 'jobs', 'repositories', 'repository_id')
    remove_orphans_for_table(Job, 'jobs', 'commits', 'commit_id')
    remove_orphans_for_table(Job, 'jobs', 'stages', 'stage_id')
    remove_orphans_for_table(Branch, 'branches', 'repositories', 'repository_id')
    remove_orphans_for_table(Branch, 'branches', 'builds', 'last_build_id')
    remove_orphans_for_table(Tag, 'tags', 'repositories', 'repository_id')
    remove_orphans_for_table(Tag, 'tags', 'builds', 'last_build_id')
    remove_orphans_for_table(Commit, 'commits', 'repositories', 'repository_id')
    remove_orphans_for_table(Commit, 'commits', 'branches', 'branch_id')
    remove_orphans_for_table(Commit, 'commits', 'tags', 'tag_id')
    remove_orphans_for_table(Cron, 'crons', 'branches', 'branch_id')
    remove_orphans_for_table(PullRequest, 'pull_requests', 'repositories', 'repository_id')
    remove_orphans_for_table(SslKey, 'ssl_keys', 'repositories', 'repository_id')
    remove_orphans_for_table(Request, 'requests', 'commits', 'commit_id')
    remove_orphans_for_table(Request, 'requests', 'pull_requests', 'pull_request_id')
    remove_orphans_for_table(Request, 'requests', 'branches', 'branch_id')
    remove_orphans_for_table(Request, 'requests', 'tags', 'tag_id')
    remove_orphans_for_table(Stage, 'stages', 'builds', 'build_id')
  end

  def remove_orphans_for_table(model_class, table_a_name, table_b_name, fk_name)
    for_delete = model_class.find_by_sql(%{
      select a.*
      from #{table_a_name} a
      left join #{table_b_name} b
      on a.#{fk_name} = b.id
      where
        a.#{fk_name} is not null
        and b.id is null;
    })

    if config.dry_run
      key = table_a_name.to_sym
      dry_run_report[key] = [] if dry_run_report[key].nil?
      dry_run_report[key].concat(for_delete.map(&:id))
      dry_run_report[key].uniq!
    else
      model_class.where(id: for_delete.map(&:id)).destroy_all
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
