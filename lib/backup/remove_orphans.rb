# frozen_string_literal: true

require 'byebug'

class Backup
  class RemoveOrphans
    attr_reader :config

    def initialize(config, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
    end

    def dry_run_report
      @dry_run_reporter.report
    end

    def run
      if @config.orphans_table
        run_for_specified(@config.orphans_table)
      else
        run_for_all
      end
    end

    def run_for_all
      cases.each do |model_block|
        process_model_block(model_block)
      end
    end

    def run_for_specified(table_name)
      model_block = cases.find { |c| c[:main_model] == Model.get_model_by_table_name(table_name) }
      process_model_block(model_block)
    end

    def add_builds_dependencies_to_dry_run_report(ids_for_delete)
      repos_for_delete = Repository.where(current_build_id: ids_for_delete)
      jobs_for_delete = Job.where(source_id: ids_for_delete)
      @dry_run_reporter.add_to_report(:repositories, *repos_for_delete.map(&:id))
      @dry_run_reporter.add_to_report(:jobs, *jobs_for_delete.map(&:id))
    end

    def process_model_block(model_block)
      model_block[:relations].each do |relation|
        process_relationship(
          main_model: model_block[:main_model],
          related_model: relation[:related_model],
          fk_name: relation[:fk_name],
          method: model_block[:method],
          dry_run_complement: model_block[:dry_run_complement]
        )
      end
    end

    def process_relationship(args)
      main_model = args[:main_model]
      related_model = args[:related_model]
      fk_name = args[:fk_name]
      method = args[:method] || :delete_all
      dry_run_complement = args[:dry_run_complement]

      main_table = main_model.table_name
      related_table = related_model.table_name

      for_delete = main_model.find_by_sql(%{
        select a.*
        from #{main_table} a
        left join #{related_table} b
        on a.#{fk_name} = b.id
        where
          a.#{fk_name} is not null
          and b.id is null;
      })

      ids_for_delete = for_delete.map(&:id)

      if config.dry_run
        key = main_table.to_sym
        @dry_run_reporter.add_to_report(key, *ids_for_delete)
        dry_run_complement.call(ids_for_delete) if dry_run_complement
      else
        main_model.where(id: ids_for_delete).send(method)
      end
    end

    def cases
      [
        {
          main_model: Repository,
          relations: [
            {related_model: Build, fk_name: 'current_build_id'},
            {related_model: Build, fk_name: 'last_build_id'}
          ]
        }, {
          main_model: Build,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'},
            {related_model: Commit, fk_name: 'commit_id'},
            {related_model: Request, fk_name: 'request_id'},
            {related_model: PullRequest, fk_name: 'pull_request_id'},
            {related_model: Branch, fk_name: 'branch_id'},
            {related_model: Tag, fk_name: 'tag_id'}
          ],
          method: :destroy_all,
          dry_run_complement: -> (ids) { add_builds_dependencies_to_dry_run_report(ids) }
        }, {
          main_model: Job,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'},
            {related_model: Commit, fk_name: 'commit_id'},
            {related_model: Stage, fk_name: 'stage_id'},
          ]
        }, {
          main_model: Branch,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'},
            {related_model: Build, fk_name: 'last_build_id'}
          ]
        }, {
          main_model: Tag,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'},
            {related_model: Build, fk_name: 'last_build_id'}
          ]
        }, {
          main_model: Commit,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'},
            {related_model: Branch, fk_name: 'branch_id'},
            {related_model: Tag, fk_name: 'tag_id'}
          ]
        }, {
          main_model: Cron,
          relations: [
            {related_model: Branch, fk_name: 'branch_id'}
          ]
        }, {
          main_model: PullRequest,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'}
          ]
        }, {
          main_model: SslKey,
          relations: [
            {related_model: Repository, fk_name: 'repository_id'}
          ]
        }, {
          main_model: Request,
          relations: [
            {related_model: Commit, fk_name: 'commit_id'},
            {related_model: PullRequest, fk_name: 'pull_request_id'},
            {related_model: Branch, fk_name: 'branch_id'},
            {related_model: Tag, fk_name: 'tag_id'}
          ]
        }, {
          main_model: Stage,
          relations: [
            {related_model: Build, fk_name: 'build_id'}
          ]
        }
      ]
    end
  end
end
