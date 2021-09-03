# frozen_string_literal: true
require 'optparse'

class Config
  attr_reader :if_backup,
    :dry_run,
    :limit,
    :threshold,
    :files_location,
    :database_url,
    :user_id,
    :repo_id,
    :org_id,
    :move_logs,
    :remove_orphans,
    :destination_db_url

  def initialize(args={}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    set_values(args)
    check_values
  end

  def set_values(args)
    config = yaml_load('config/settings.yml')
    connection_details = yaml_load('config/database.yml')
    argv_opts = argv_options
    @if_backup = first_not_nil(
      args[:if_backup],
      argv_opts[:if_backup],
      ENV['IF_BACKUP'],
      config.dig('backup', 'if_backup'),
      true
    )
    @dry_run = first_not_nil(
      args[:dry_run],
      argv_opts[:dry_run],
      ENV['BACKUP_DRY_RUN'],
      config.dig('backup', 'dry_run'),
      false
    )
    @limit = first_not_nil(
      args[:limit],
      argv_opts[:limit],
      ENV['BACKUP_LIMIT'],
      config.dig('backup', 'limit'),
      1000
    )
    @threshold = first_not_nil(
      args[:threshold],
      argv_opts[:threshold],
      ENV['BACKUP_THRESHOLD'],
      config.dig('backup', 'threshold')
    )
    @files_location = first_not_nil(
      args[:files_location],
      argv_opts[:files_location],
      ENV['BACKUP_FILES_LOCATION'],
      config.dig('backup', 'files_location'),
      './dump'
    )
    @database_url = first_not_nil(
      args[:database_url],
      argv_opts[:database_url],
      ENV['DATABASE_URL'],
      connection_details.dig(ENV['RAILS_ENV'])
    )
    @user_id = first_not_nil(
      args[:user_id],
      argv_opts[:user_id],
      ENV['USER_ID'],
      config.dig('backup', 'user_id')
    )
    @repo_id = first_not_nil(
      args[:repo_id],
      argv_opts[:repo_id],
      ENV['REPO_ID'],
      config.dig('backup', 'repo_id')
    )
    @org_id = first_not_nil(
      args[:org_id],
      argv_opts[:org_id],
      ENV['ORG_ID'],
      config.dig('backup', 'org_id')
    )
    @move_logs = first_not_nil(
      args[:move_logs],
      argv_opts[:move_logs],
      ENV['BACKUP_MOVE_LOGS'],
      config.dig('backup', 'move_logs'),
      false
    )
    @remove_orphans = first_not_nil(
      args[:remove_orphans],
      argv_opts[:remove_orphans],
      ENV['BACKUP_REMOVE_ORPHANS'],
      config.dig('backup', 'remove_orphans'),
      false
    )
    @destination_db_url = first_not_nil(
      args[:destination_db_url],
      argv_opts[:destination_db_url],
      ENV['BACKUP_DESTINATION_DB_URL'],
      connection_details.dig(ENV['RAILS_ENV'], 'destination')
    )
  end

  def check_values
    if !@move_logs && !@threshold
      message = abort_message("Please provide the threshold argument. Data younger than it will be omitted. " +
        "Threshold defines number of months from now.")
      abort message
    end

    if !@database_url
      message = abort_message("Please provide proper database URL.")
      abort message
    end

    if (@move_logs && !@destination_db_url)
      abort "\nFor moving logs you need to specify your destination database. Example usage:\n" +
      "\n  $ bin/travis_backup 'postgres://source_url' --move_logs --destination_db_url 'postgres://destination_url'\n" +
      "\nor using in code:\n" +
      "\n  Backup.new(database_url: 'postgres://source_url', destination_db_url: 'postgres://destination_url', move_logs: true)\n" +
      "\nYou can also set it using environment variables or configuration files.\n"  
    end
  end

  def abort_message(intro)
    "\n#{intro} Example usage:\n"+
    "\n  $ bin/travis_backup 'postgres://my_database_url' --threshold 6\n" +
    "\nor using in code:\n" +
    "\n  Backup.new(database_url: 'postgres://my_database_url', threshold: 6)\n" +
    "\nYou can also set it using environment variables or configuration files.\n"
  end

  def argv_options
    argv_copy = ARGV.clone
    options = {}
    OptionParser.new do |opt|
      opt.on('-b', '--backup') { |o| options[:if_backup] = o }
      opt.on('-d', '--dry_run') { |o| options[:dry_run] = o }
      opt.on('-l', '--limit X') { |o| options[:limit] = o.to_i }
      opt.on('-t', '--threshold X') { |o| options[:threshold] = o.to_i }
      opt.on('-f', '--files_location X') { |o| options[:files_location] = o }
      opt.on('-u', '--user_id X') { |o| options[:user_id] = o.to_i }
      opt.on('-r', '--repo_id X') { |o| options[:repo_id] = o.to_i }
      opt.on('-o', '--org_id X') { |o| options[:org_id] = o.to_i }
      opt.on('--move_logs') { |o| options[:move_logs] = o }
      opt.on('--destination_db_url X') { |o| options[:destination_db_url] = o }
    end.parse!

    options[:database_url] = ARGV.shift if ARGV[0]
    argv_copy.each do |arg|
      ARGV.push(arg)
    end
    options
  end

  def first_not_nil(*arr)
    arr.compact.first
  end

  def yaml_load(url)
    begin
      YAML.load(File.open(url))
    rescue => e
      {}
    end
  end
end
