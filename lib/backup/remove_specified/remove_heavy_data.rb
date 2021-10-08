# frozen_string_literal: true

require 'backup/save_file'

module RemoveHeavyData
  include SaveFile

  def remove_heavy_data_for_repos_owned_by(owner_id, owner_type)
    Repository.where('owner_id = ? and owner_type = ?', owner_id, owner_type).order(:id).each do |repository|
      remove_heavy_data_for_repo(repository)
    end
  end

  def remove_heavy_data_for_repo(repository)
    remove_repo_builds(repository)
    remove_repo_requests(repository)
  end

  def remove_repo_builds(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    threshold = @config.threshold.to_i.months.ago.to_datetime
    current_build_id = repository.current_build_id || -1
    repository.builds.where('created_at < ? and id != ?', threshold, current_build_id)
              .in_batches(of: @config.limit.to_i).map do |builds_batch|
      if @config.if_backup
        file_prefix = "repository_#{repository.id}"
        save_and_destroy_builds_batch(builds_batch, file_prefix)
      else
        destroy_builds_batch(builds_batch)
      end
    end.compact.reduce(&:&)
  end

  def remove_repo_requests(repository)
    threshold = @config.threshold.to_i.months.ago.to_datetime
    repository.requests.where('created_at < ?', threshold)
              .in_batches(of: @config.limit.to_i).map do |requests_batch|
      @config.if_backup ? save_and_destroy_requests_batch(requests_batch, repository) : destroy_requests_batch(requests_batch)
    end.compact
  end

  private

  def save_and_destroy_builds_batch(builds_batch, file_prefix)
    builds_export = builds_batch.map(&:attributes)

    dependencies_saved = builds_batch.map do |build|
      save_build_jobs_and_logs(build, file_prefix)
    end.reduce(&:&)

    if dependencies_saved
      file_name = "#{file_prefix}_builds_#{builds_batch.first.id}-#{builds_batch.last.id}.json"
      pretty_json = JSON.pretty_generate(builds_export)
      save_file(file_name, pretty_json) ? destroy_builds_batch(builds_batch) : false
    else
      false
    end
  end

  def save_build_jobs_and_logs(build, file_prefix)
    build.jobs.in_batches(of: @config.limit.to_i).map do |jobs_batch|
      file_prefix = "#{file_prefix}_build_#{build.id}"
      save_jobs_batch(jobs_batch, file_prefix)
    end.compact.reduce(&:&)
  end

  def save_jobs_batch(jobs_batch, file_prefix)
    jobs_export = jobs_batch.map(&:attributes)

    logs_saved = jobs_batch.map do |job|
      save_job_logs(job, file_prefix)
    end.reduce(&:&)

    if logs_saved
      file_name = "#{file_prefix}_jobs_#{jobs_batch.first.id}-#{jobs_batch.last.id}.json"
      pretty_json = JSON.pretty_generate(jobs_export)
      save_file(file_name, pretty_json)
    else
      false
    end
  end

  def save_job_logs(job, file_prefix)
    job.logs.in_batches(of: @config.limit.to_i).map do |logs_batch|
      file_prefix = "#{file_prefix}_job_#{job.id}"
      save_logs_batch(logs_batch, file_prefix)
    end.compact.reduce(&:&)
  end

  def save_logs_batch(logs_batch, file_prefix)
    logs_export = logs_batch.map(&:attributes)
    file_name = "#{file_prefix}_logs_#{logs_batch.first.id}-#{logs_batch.last.id}.json"
    pretty_json = JSON.pretty_generate(logs_export)
    save_file(file_name, pretty_json)
  end

  def destroy_builds_batch(builds_batch)
    return destroy_builds_batch_dry(builds_batch) if @config.dry_run

    builds_batch.each(&:destroy)
  end

  def destroy_builds_batch_dry(builds_batch)
    @dry_run_reporter.add_to_report(:builds, *builds_batch.map(&:id))

    jobs_ids = builds_batch.map do |build|
      build.jobs.map(&:id) || []
    end.flatten

    @dry_run_reporter.add_to_report(:jobs, *jobs_ids)

    logs_ids = builds_batch.map do |build|
      build.jobs.map do |job|
        job.logs.map(&:id) || []
      end.flatten || []
    end.flatten

    @dry_run_reporter.add_to_report(:logs, *logs_ids)
  end

  def save_and_destroy_requests_batch(requests_batch, repository)
    requests_export = requests_batch.map(&:attributes)
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
    @dry_run_reporter.add_to_report(:requests, *requests_batch.map(&:id))
  end
end
