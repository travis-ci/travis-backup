# frozen_string_literal: true

require 'backup/remove_specified/remove_with_all_dependencies'
require 'backup/remove_specified/remove_heavy_data'

class Backup
  class RemoveSpecified
    include RemoveHeavyData
    include RemoveWithAllDependencies

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
        remove_heavy_data_for_repos_owned_by(user_id, 'User')
      else
        remove_user_with_dependencies(user_id)
      end
    end

    def process_organization(org_id)
      if @config.threshold
        remove_heavy_data_for_repos_owned_by(org_id, 'Organization')
      else
        remove_org_with_dependencies(org_id)
      end
    end

    def process_repo_with_id(repo_id)
      if @config.threshold
        remove_heavy_data_for_repo(Repository.find(repo_id))
      else
        remove_repo_with_dependencies(repo_id)
      end
    end

    def process_all_repos
      Repository.order(:id).each do |repository|
        remove_heavy_data_for_repo(repository)
      end
    end
  end
end
