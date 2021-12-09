# frozen_string_literal: true

require 'active_support/core_ext/array'
require 'active_support/time'
require 'config'
require 'db_helper'
require 'dry_run_reporter'
require 'models/abuse'
require 'models/annotation'
require 'models/repository'
require 'models/branch'
require 'models/broadcast'
require 'models/build'
require 'models/commit'
require 'models/cron'
require 'models/email'
require 'models/invoice'
require 'models/job'
require 'models/log'
require 'models/membership'
require 'models/message'
require 'models/organization'
require 'models/owner_group'
require 'models/permission'
require 'models/pull_request'
require 'models/queueable_job'
require 'models/repository'
require 'models/request'
require 'models/ssl_key'
require 'models/stage'
require 'models/star'
require 'models/subscription'
require 'models/tag'
require 'models/token'
require 'models/trial_allowance'
require 'models/trial'
require 'models/user_beta_feature'
require 'models/user'
require 'backup/move_logs'
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
    if @config.move_logs
      Backup::MoveLogs.new(@config, @db_helper, @dry_run_reporter).run
    elsif @config.load_from_files
      Backup::LoadFromFiles.new(@config, @dry_run_reporter).run
    elsif @config.remove_orphans
      Backup::RemoveOrphans.new(@config, @dry_run_reporter).run
    else
      Backup::RemoveSpecified.new(@config, @dry_run_reporter).run(args)
    end

    @dry_run_reporter.print_report if @config.dry_run
  end
end
