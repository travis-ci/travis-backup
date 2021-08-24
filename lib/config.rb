# frozen_string_literal: true
require 'optparse'

class Config
  attr_reader :if_backup, :dry_run, :limit, :threshold, :files_location, :database_url, :user_id, :repo_id, :org_id

  def initialize(args={}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
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
      ENV['BACKUP_BACKUP_FILES_LOCATION'],
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
    if !@threshold
      raise 'Please provide the threshold argument. Data younger than it will be omitted.' +
        "Threshold defines number of months from now. It can be set like:\n\n"+
        "  $ bin/travis_backup --threshold 6\n"
    end
  end

  def argv_options
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
    end.parse!

    options[:database_url] = ARGV[0] if ARGV[0]
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
