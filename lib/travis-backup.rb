# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'db_helper'
require 'dry_run_reporter'
require 'backup/remove_specified'
require 'models'

# main travis-backup class
class Backup
  attr_accessor :config

  def initialize(config_args={})
    @config = Config.new(config_args)
    @db_helper = DbHelper.new(@config)

    if @config.dry_run
      @dry_run_reporter = DryRunReporter.new
    end
  end

  def dry_run_report
    @dry_run_reporter.report
  end

  def run(args={})
    Backup::RemoveSpecified.new(@config, @dry_run_reporter).run(args)

    @dry_run_reporter.print_report if @config.dry_run
  end
end
