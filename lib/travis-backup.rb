# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'models/repository'
require 'models/log'

# main travis-backup class
class Backup
  attr_accessor :config

  def initialize(config_args={})
    @config = Config.new(config_args)

    if @config.dry_run
      @dry_run_removed = {builds: [], jobs: []}
    end

    connect_db
  end

  def connect_db(url=@config.database_url)
    ActiveRecord::Base.establish_connection(url)
  end

  def run(args={})
    return move_logs if @config.move_logs

    user_id = args[:user_id] || @config.user_id
    repo_id = args[:repo_id] || @config.repo_id
    org_id = args[:org_id] || @config.org_id

    if user_id
      owner_id = user_id
      owner_type = 'User'
    elsif org_id
      owner_id = org_id
      owner_type = 'Organization'
    elsif repo_id
      repo_id = repo_id
    end

    if owner_id
      Repository.where('owner_id = ? and owner_type = ?', owner_id, owner_type).order(:id).each do |repository|
        process_repo(repository)
      end
    elsif repo_id
      repository = Repository.find(repo_id)
      process_repo(repository)
    else
      Repository.order(:id).each do |repository|
        process_repo(repository)
      end
    end

    if @config.dry_run
      puts 'Dry run active. The following data would be removed in normal mode:'
      puts " - builds: #{@dry_run_removed[:builds].to_json}"
      puts " - jobs: #{@dry_run_removed[:jobs].to_json}"
    end
  end

  def move_logs
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

  def remove_orphans
    repositories = Repository.find_by_sql(
      "select r.* from repositories r left join builds b on r.current_build_id = b.id where (r.current_build_id is not null) and (b.id is null);"
    )
    for_delete = repositories.map(&:id)
    Repository.where(id: for_delete).delete_all
  end

  def remove_orphans2
    build_ids = {}
    Build.pluck(:id).each do |id|
      build_ids[id] = true
    end

    repositories = Repository.find_by_sql(
      "select * from repositories where current_build_id is not null;"
    )
    for_delete = []
    repositories.each do |repo|
      for_delete.push(repo.id) if !build_ids[repo.current_build_id]
    end
    Repository.where(id: for_delete).delete_all
  end

  def remove_orphans3
    repositories = Repository.find_by_sql(
      "select * from repositories where current_build_id is not null and current_build_id not in (select id from builds);"
    )
    for_delete = repositories.map(&:id)
    Repository.where(id: for_delete).delete_all
  end

  def remove_orphans4
    ActiveRecord::Base.connection.execute("delete from repositories where current_build_id is not null and current_build_id not in (select id from builds);")
  end

  def process_repo(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    threshold = @config.threshold.to_i.months.ago.to_datetime
    current_build_id = repository.current_build_id || -1
    repository.builds.where('created_at < ? and id != ?', threshold, current_build_id)
              .in_groups_of(@config.limit.to_i, false).map do |builds_batch|
      @config.if_backup ? save_and_destroy_batch(builds_batch, repository) : destroy_batch(builds_batch)
    end.compact
  end

  private

  def save_and_destroy_batch(builds_batch, repository)
    builds_export = export_builds(builds_batch)
    file_name = "repository_#{repository.id}_builds_#{builds_batch.first.id}-#{builds_batch.last.id}.json"
    pretty_json = JSON.pretty_generate(builds_export)
    if save_file(file_name, pretty_json)
      destroy_batch(builds_batch)
    end
    builds_export
  end

  def destroy_batch(builds_batch)
    return destroy_batch_dry(builds_batch) if @config.dry_run

    builds_batch.each(&:destroy)
  end

  def destroy_batch_dry(builds_batch)
    @dry_run_removed[:builds].concat(builds_batch.map(&:id))
    jobs = builds_batch.map do |build|
      build.jobs.map(&:id) || []
    end.flatten
    @dry_run_removed[:jobs].concat(jobs)
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

      job_export
    end
  end
end
