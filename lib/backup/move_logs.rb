# frozen_string_literal: true

class Backup
  class MoveLogs
    attr_reader :config

    def initialize(config, db_helper, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
      @db_helper = db_helper
    end

    def run
      return run_dry if @config.dry_run

      @db_helper.connect_db(@config.database_url)
      Log.order(:id).in_groups_of(@config.limit.to_i, false).map do |logs_batch|
        log_hashes = logs_batch.as_json
        @db_helper.connect_db(@config.destination_db_url)

        log_hashes.each do |log_hash|
          new_log = Log.new(log_hash)
          new_log.save!
        end

        @db_helper.connect_db(@config.database_url)

        logs_batch.each(&:destroy)
      end
    end

    def run_dry
      ids = Log.order(:id).map(&:id)
      @dry_run_reporter.add_to_report(:logs, *ids)
    end  
  end
end
