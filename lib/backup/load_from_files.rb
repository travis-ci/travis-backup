# frozen_string_literal: true

class Backup
  class LoadFromFiles
    def initialize(config, dry_run_reporter=nil)
      @config = config
      @dry_run_reporter = dry_run_reporter
    end

    def run
    end
  end
end