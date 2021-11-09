# frozen_string_literal: true

require 'backup/save_file'

module RemoveHeavyData
  include SaveIdHashToFile

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
    builds_dependencies = repository.builds.where('created_at < ?', threshold).map do |build|
      next if should_build_be_filtered?(build)

      result = build.ids_of_all_dependencies
      result.add(:build, build.id)
      result
    end.compact

    ids_to_remove = IdHash.join(*builds_dependencies)
    @subfolder = "repository_#{repository.id}_old_builds_#{time_for_subfolder}"
    process_ids_to_remove(ids_to_remove)
  end

  def remove_repo_requests(repository)
    threshold = @config.threshold.to_i.months.ago.to_datetime

    requests_dependencies = repository.requests.where('created_at < ?', threshold).map do |request|
      hash_with_filtered = request.ids_of_all_dependencies_with_filtered(dependencies_to_filter)
      hash_with_filtered[:main].add(:request, request.id)
      hash_with_filtered[:main].join(hash_with_filtered[:filtered_out])
      hash_with_filtered
    end

    requests_dependencies.each do |hash|
      filtered_builds = hash[:filtered_out]&.[](:build)&.map { |id| Build.find(id) }
      filtered_builds&.each(&:nullify_default_dependencies) unless @config.dry_run
    end

    ids_to_remove = IdHash.join(*(requests_dependencies.map { |h| h[:main] }))
    @subfolder = "repository_#{repository.id}_old_requests_#{time_for_subfolder}"
    process_ids_to_remove(ids_to_remove)
  end

  private

  def process_ids_to_remove(ids_to_remove)
    if @config.dry_run
      @dry_run_reporter.add_to_report(ids_to_remove.with_table_symbols)
    else
      save_id_hash_to_file(ids_to_remove) if @config.if_backup
      ids_to_remove.remove_entries_from_db
    end
  end

  def time_for_subfolder
    Time.now.to_s.parameterize.underscore
  end

  def should_build_be_filtered?(build)
    dependencies_to_filter[:build].map do |association|
      build.send(association).to_a
    end.flatten.any?
  end

  def dependencies_to_filter
    {
      build: [
        :repos_for_that_this_build_is_current,
        :repos_for_that_this_build_is_last,
        :tags_for_that_this_build_is_last,
        :branches_for_that_this_build_is_last
      ]
    }
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
