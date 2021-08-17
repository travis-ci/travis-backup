# frozen_string_literal: true

# Config for travis-backup
class Config
  attr_reader :if_backup, :limit, :delay, :files_location, :database_url

  def initialize(args={}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    config = YAML.load(File.open('config/settings.yml'))
    connection_details = YAML.load(File.open('config/database.yml'))

    if !args[:if_backup].nil?
      @if_backup = args[:if_backup]
    elsif !ENV['IF_BACKUP'].nil?
      @if_backup = ENV['IF_BACKUP']
    else
      @if_backup = config['backup']['if_backup']
    end

    @limit = args[:limit] || ENV['BACKUP_LIMIT'] || config['backup']['limit']
    @delay = args[:delay] || ENV['BACKUP_DELAY'] || config['backup']['delay']
    @files_location = args[:files_location] || ENV['BACKUP_FILES_LOCATION'] || config['backup']['files_location']
    @database_url = args[:database_url] || ENV['DATABASE_URL'] || connection_details['development']
  end
end
