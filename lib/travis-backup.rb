# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'models/repository'

# main travis-backup class
class Backup
  def initialize(config_args={})
    @config = Config.new(config_args)
    connect_db
  end

  def connect_db
    ActiveRecord::Base.establish_connection(@config.database_url)
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
  end

  def process_repo(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    threshold = @config.threshold.to_i.months.ago.to_datetime
    current_build_id = repository.current_build_id || -1
    repository.builds.where('created_at < ? and id != ?', threshold, current_build_id)
              .in_groups_of(@config.limit.to_i, false).map do |builds_batch|
      if builds_batch.count == @config.limit.to_i
        @config.if_backup ? save_and_destroy_batch(builds_batch, repository) : destroy_batch(builds_batch)
      end
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
    puts 'Dry mode: this code would destroy the following data in normal mode:'
    puts ' - builds: ' + builds_batch.map(&:id).to_json

    jobs = builds_batch.map do |build|
      build.jobs.map(&:id) || []
    end.flatten.to_json

    puts " - jobs: #{jobs}"
  end

  def save_file(file_name, content) # rubocop:disable Metrics/MethodLength
    return save_file_dry(file_name, content) if @config.dry_run

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

  def save_file_dry(file_name, content)
    puts 'Dry mode: this code would generate the following files in normal mode:'
    puts "\n#{file_path(file_name)}:\n\n"
    puts content
    return true
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
