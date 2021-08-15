# frozen_string_literal: true

# Config for travis-backup
class Config
  attr_reader :limit, :delay, :database_url

  def initialize # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    config = YAML.load(File.open('config/settings.yml'))
    connection_details = YAML.load(File.open('config/database.yml'))

    @limit = ENV['BACKUP_LIMIT'] || config['backup']['limit']
    @delay = ENV['BACKUP_DELAY'] || config['backup']['delay']
    @database_url = ENV['DATABASE_URL'] || connection_details['development']
  end
end
