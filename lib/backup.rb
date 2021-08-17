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

  def run
    export
  end

  def connect_db
    ActiveRecord::Base.establish_connection(@config.database_url)
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

  def process_repo(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    delay = @config.delay.to_i.months.ago.to_datetime
    current_build_id = repository.current_build_id || -1
    repository.builds.where('created_at < ? and id != ?', delay, current_build_id)
              .in_groups_of(@config.limit.to_i, false).map do |builds_batch|
      if builds_batch.count == @config.limit.to_i
        @config.if_backup ? save_batch(builds_batch, repository) : builds_batch.each(&:destroy)
      end
    end
  end

  private

  def save_batch(builds_batch, repository)
    builds_export = export_builds(builds_batch)
    file_name = "repository_#{repository.id}_builds_#{builds_batch.first.id}-#{builds_batch.last.id}.json"
    pretty_json = JSON.pretty_generate(builds_export)
    if upload(file_name, pretty_json)
      builds_batch.each(&:destroy)
    end
    builds_export
  end

  def upload(file_name, content) # rubocop:disable Metrics/MethodLength
    uploaded = false
    begin
      unless File.directory?(@config.files_location)
        FileUtils.mkdir_p(@config.files_location)
      end

      File.open("#{@config.files_location}/#{file_name}", 'w') do |file|
        file.write(content)
        file.close
        uploaded = true
      end
    rescue => e
      print "Failed to save #{file_name}, error: #{e.inspect}\n"
    end
    uploaded
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
