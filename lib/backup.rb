# frozen_string_literal: true

require 'models/repository'
require 'config'
require 'pry'
require 'google/cloud/storage'

# main travis-backup class
class Backup
  def initialize
    @config = Config.new
    connect_gce
    connect_db
  end

  def run
    export
    purge
  end

  def connect_db
    ActiveRecord::Base.establish_connection(@config.database_url)
  end

  def connect_gce
    storage = Google::Cloud::Storage.new(
      project_id: @config.gce_project,
      credentials: @config.gce_credentials
    )
    @bucket = storage.bucket(@config.gce_bucket)
  end

  def purge
    @bucket.lifecycle do |lifecycle|
      lifecycle.clear
      lifecycle.add_delete_rule(age: @config.housekeeping_period.to_i)
    end
  end

  def export(owner_id = nil)
    if owner_id
      Repository.where('owner_id = ?', owner_id).order(:id).each do |repository|
        process_repo(repository)
      end
    else
      Repository.order(:id).each do |repository|
        process_repo(repository)
      end
    end
  end

  private

  def process_repo(repository) # rubocop:disable Metrics/AbcSize
    repository.build.where('created_at < ?', @config.delay.months.ago.to_datetime).in_groups_of(@config.limit) do
      |builds|
      builds_export = export_builds(builds)
      file_name = "repository_#{repository.id}_builds_#{builds.compact.first.id}-#{builds.compact.last.id}.json"
      builds.compact.each(&:destroy) if upload(file_name, JSON.pretty_generate(builds_export))
    end
  end

  def upload(file_name, content) # rubocop:disable Metrics/MethodLength
    uploaded = false
    begin
      File.open(file_name, 'w') do |file|
        file.write(content)
        file.close
        remote_file = @bucket.create_file(file_name, file_name)
        uploaded = remote_file.name == file_name
      end
    rescue e
      print "Failed to save #{file_name}, error: #{e.inspect}\n"
    ensure
      File.delete(file_name)
    end
    uploaded
  end

  def export_builds(builds)
    builds.compact.map do |build|
      build_export = build.attributes
      build_export[:build_config] = build.build_config.attributes
      build_export[:jobs] = export_jobs(build.jobs)

      build_export
    end
  end

  def export_jobs(jobs)
    jobs.map do |job|
      job_export = job.attributes
      job_export[:job_config] = job.job_config.attributes
      job_export[:log_url] = "#{@config.logs_url}/#{job.id}/log.txt"

      job_export
    end
  end
end
