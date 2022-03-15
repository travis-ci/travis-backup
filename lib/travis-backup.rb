# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'db_helper'
require 'dry_run_reporter'
require 'backup/remove_orphans'
require 'backup/load_from_files'
require 'backup/remove_specified'

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
    if @config.load_from_files
      Backup::LoadFromFiles.new(@config, @dry_run_reporter).run
    elsif @config.remove_orphans
      Backup::RemoveOrphans.new(@config, @dry_run_reporter).run
    else
      Backup::RemoveSpecified.new(@config, @dry_run_reporter).run(args)
    end

    @dry_run_reporter.print_report if @config.dry_run
  end
end
