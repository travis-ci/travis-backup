# frozen_string_literal: true

# Config for travis-backup
class Config
  attr_reader :if_backup, :limit, :delay, :files_location, :database_url

  def initialize(args={}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    begin
      config = YAML.load(File.open('config/settings.yml'))
    rescue => e
      config = {}
    end

    begin
      connection_details = YAML.load(File.open('config/database.yml'))
    rescue => e
      connection_details = {}
    end


    if !args[:if_backup].nil?
      @if_backup = args[:if_backup]
    elsif !ENV['IF_BACKUP'].nil?
      @if_backup = ENV['IF_BACKUP']
    elsif !config.dig('backup', 'if_backup').nil?
      @if_backup = config.dig('backup', 'if_backup')
    else
      @if_backup = true
    end

    @limit = args[:limit] || ENV['BACKUP_LIMIT'] || config.dig('backup', 'limit') || 1000
    @delay = args[:delay] || ENV['BACKUP_DELAY'] || config.dig('backup', 'delay') || 6
    @files_location = args[:files_location] || ENV['BACKUP_FILES_LOCATION'] || config.dig('backup', 'files_location') || './dump'
    @database_url = args[:database_url] || ENV['DATABASE_URL'] || connection_details.dig(ENV['RAILS_ENV'])
  end
end
