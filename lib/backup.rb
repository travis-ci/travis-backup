# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'google/cloud/storage'
require 'models/build_backup'
require 'models/repository'
require 'redis'

# main travis-backup class
class Backup
  def initialize
    @config = Config.new
    connect_gce
    connect_db
    connect_redis
  end

  def run
    export
    purge
  end

  def connect_db
    ActiveRecord::Base.establish_connection(@config.database_url)
  end

  def connect_gce
    return unless @config.gce_project && @config.gce_credentials

    storage = Google::Cloud::Storage.new(
      project_id: @config.gce_project,
      credentials: @config.gce_credentials
    )
    @bucket = storage.bucket(@config.gce_bucket)
  end

  def connect_redis
    @redis = Redis.new(url: @config.redis_url)
  end

  def purge
    BuildBackup.where('created_at < ?', @config.housekeeping_period.to_i.days.ago.to_datetime) do |backup|
      purge_backup(backup)
    end
  end

  def export(owner_id = nil)
    if owner_id
      Repository.where('owner_id = ?', owner_id).order(:id).each do |repository|
        process_repo(repository)
      end
    else
      Repository.find_in_batches.each do |group|
        group.each do |repository|
          process_repo(repository)
        end
      end
    end
  end

  def process_repo(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    repository.builds.where('created_at < ?', @config.delay.to_i.months.ago.to_datetime)
              .in_groups_of(@config.limit.to_i, false).map do |builds|
      if builds.count == @config.limit.to_i
        builds_export = export_builds(builds)
        file_name = "repository_#{repository.id}_builds_#{builds.first.id}-#{builds.last.id}.json"
        pretty_json = JSON.pretty_generate(builds_export)
        if upload(file_name, pretty_json)
          BuildBackup.new(repository_id: repository.id, file_name: file_name).save!
          builds.each(&:destroy)
        end
        builds_export
      end
    end
  end

  def purge_backup(backup)
    begin
      @bucket.file(backup.file_name).delete
    rescue
      print "Unable to remove file #{backup.file_name}\n"
    end
    backup.destroy
  end

  private

  def upload(file_name, content) # rubocop:disable Metrics/MethodLength
    uploaded = false
    begin
      File.open(file_name, 'w') do |file|
        file.write(content)
        file.close
        remote_file = @bucket.create_file(file_name, file_name)
        uploaded = remote_file.name == file_name
      end
    rescue => e
      print "Failed to save #{file_name}, error: #{e.inspect}\n"
    ensure
      File.delete(file_name)
    end
    uploaded
  end

  def generate_log_token(job_id)
    token = SecureRandom.urlsafe_base64(16)
    @redis.set("l:#{token}", job_id)
    @redis.expire("l:#{token}", @config.housekeeping_period.to_i * 86400)
    token
  end

  def export_builds(builds)
    builds.map do |build|
      build_export = build.attributes
      build_export[:build_config] = build.build_config&.attributes
      build_export[:jobs] = export_jobs(build.jobs)

      build_export
    end
  end

  def export_jobs(jobs)
    jobs.map do |job|
      job_export = job.attributes
      job_export[:job_config] = job.job_config&.attributes
      job_export[:log_url] = "#{@config.logs_url}/#{job.id}/log.txt"
      job_export[:log_url] += "?log.token=#{generate_log_token(job.id)}" if job.repository&.private?

      job_export
    end
  end
end
