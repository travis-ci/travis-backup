# frozen_string_literal: true

class Backup
  class RemoveSpecified
    attr_reader :config

    def initialize(config, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
    end

    def dry_run_report
      @dry_run_reporter.report
    end

    def run(args={})
      user_id = args[:user_id] || @config.user_id
      repo_id = args[:repo_id] || @config.repo_id
      org_id = args[:org_id] || @config.org_id

      if user_id
        process_user(user_id)
      elsif org_id
        process_organization(org_id)
      elsif repo_id
        process_repo_with_id(repo_id)
      else
        process_all_repos
      end
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

    def remove_user_with_dependencies(user_id)
      user = User.find(user_id)
      ids_of_all_dependencies = user.ids_of_all_dependencies(except: dependencies_to_filter)
      # puts ids_of_all_dependencies[:main][:build]
      # puts '--'
      # filter_builds_with_filtered_dependencies!(ids_of_all_dependencies)
      # remove_ids_present_in_main_from_filtered_out!(ids_of_all_dependencies)
      
      # puts ids_of_all_dependencies[:main][:build]

      remove_ids_from_hash(ids_of_all_dependencies[:main])

      user.delete
    end

    def remove_ids_present_in_main_from_filtered_out!(ids_hash)
      ids_hash[:main].each do |name, ids|
        ids.each do |id|
          ids_hash[:filtered_out][name]&.delete(id)
        end
      end
    end

    def remove_ids_from_hash(ids_hash)
      # byebug
      Build.delete(ids_hash[:build])
      ids_hash.each do |name, ids|
        next if name == :build

        model = Utils.get_model(name)
        model.delete(ids)
      end

    end

    def filter_builds_with_filtered_dependencies!(ids_of_all_dependencies)
      builds = ids_of_all_dependencies[:main][:build]
      return unless builds

      ids_to_filter = get_builds_to_filter(ids_of_all_dependencies)
      ids_to_filter.each do |id|
        builds.delete(id)
      end

      filtered = ids_of_all_dependencies[:filtered_out]
      filtered[:build] = [] if filtered[:build].nil?
      filtered[:build].concat(ids_to_filter)
      filtered[:build].uniq!
    end

    def get_builds_to_filter(ids_hash)
      builds_to_filter = []

      ids_hash[:filtered_out].each do |name, ids|
        model = Utils.get_model(name)
        model.where(id: ids).each do |instance|
          [:last_build_id, :current_build_id].each do |method|
            build_id = instance.try(method)
            builds_to_filter << build_id
          end
        end
      end

      builds_to_filter.compact!
      builds_to_filter.uniq!
    end


    # def filter_dependent_on_strangers!(ids_hash)
    #   builds_to_filter = get_builds_to_filter(ids_hash)

    #   hashes = builds_to_filter.map do |build|
    #     build.ids_of_all_dependencies(only: dependencies_to_filter)[:main]
    #   end

    #   joined_hashes = Utils.uniquely_join_hashes_of_arrays(*hashes)
    #   ids_hash[:main] = Utils.difference_of_two_hashes_of_arrays(ids_hash[:main], joined_hashes)
    # end

    # def get_builds_to_filter(ids_hash)
    #   builds_to_filter = []

    #   ids_hash[:filtered_out].each do |name, ids|
    #     model = Utils.get_model(name)
    #     model.where(id: ids).each do |instance|
    #       [:last_build_id, :current_build_id].each do |method|
    #         build_id = instance.try(method)
    #         builds_to_filter << build_id
    #       end
    #     end
    #   end

    #   builds_to_filter.compact!
    #   builds_to_filter.uniq!
    #   Build.where(id: builds_to_filter)
    # end

    def remove_org_with_dependencies(org_id)
      
    end

    def remove_repo_with_dependencies(repo_id)
      
    end

    def process_all_repos
      Repository.order(:id).each do |repository|
        process_repo(repository)
      end
    end
  
    def process_repo(repository)
      process_repo_builds(repository)
      process_repo_requests(repository)
    end
  
    def process_repo_builds(repository) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
  
    def process_repo_requests(repository)
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
      @dry_run_reporter.add_to_report(:requests, *requests_batch.map(&:id))
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
  
    def export_requests(requests)
      requests.map do |request|
        request.attributes
      end
    end    
  end
end
