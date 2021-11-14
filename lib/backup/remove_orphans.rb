# frozen_string_literal: true

require 'byebug'

class Backup
  class RemoveOrphans
    attr_reader :config

    def initialize(config, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
      @ids_to_remove = IdHash.new
    end

    def dry_run_report
      @dry_run_reporter.report
    end

    def run
      if @config.orphans_table
        check_specified(@config.orphans_table)
      else
        check_all
      end

      process_ids_to_remove
    end

    def check_all
      cases.each do |model_block|
        check_model_block(model_block)
      end
    end

    def check_specified(table_name)
      model_block = cases.find { |c| c[:main_model] == Model.get_model_by_table_name(table_name) }
      check_model_block(model_block)
    end

    def check_model_block(model_block)
      model_block[:relations].each do |relation|
        check_relationship(
          main_model: model_block[:main_model],
          related_model: relation[:related_model],
          fk_name: relation[:fk_name],
        )
      end
    end

    def check_relationship(args)
      main_model = args[:main_model]
      related_model = args[:related_model]
      fk_name = args[:fk_name]

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

      key = main_model.name.underscore.to_sym
      ids = for_delete.map(&:id)
      @ids_to_remove.add(key, *ids)
    end

    def process_ids_to_remove
      if @config.dry_run
        @dry_run_reporter.add_to_report(@ids_to_remove.with_table_symbols)
      else
        nullify_builds_dependencies
        @ids_to_remove.remove_entries_from_db
      end
    end

    def nullify_builds_dependencies
      @ids_to_remove[:build]&.each do |build_id|
        build = Build.find_by(id: build_id)
        build&.nullify_default_dependencies
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
          ]
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
