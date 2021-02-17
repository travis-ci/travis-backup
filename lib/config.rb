# frozen_string_literal: true

# Config for travis-backup
class Config
  attr_reader :limit, :delay, :housekeeping_period, :database_url, :logs_url, :gce_project,
              :gce_credentials, :gce_bucket, :redis_url

  def initialize # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    config = YAML.load(File.open('config/settings.yml'))
    connection_details = YAML.load(File.open('config/database.yml'))

    @limit = ENV['BACKUP_LIMIT'] || config['backup']['limit']
    @delay = ENV['BACKUP_DELAY'] || config['backup']['delay']
    @logs_url = ENV['LOGS_URL'] || config['backup']['logs_url']
    @housekeeping_period = ENV['BACKUP_HOUSEKEEPING_PERIOD'] || config['backup']['housekeeping_period']
    @database_url = ENV['DATABASE_URL'] || connection_details['development']
    @gce_project = ENV['GCE_PROJECT'] || config['gce']['project']
    @gce_credentials = JSON.parse(ENV['GCE_CREDENTIALS'] ||
                                  File.exist?(config['gce']['credentials']) ?
                                    File.read(config['gce']['credentials']) : '{}')
    @gce_bucket = ENV['GCE_BUCKET'] || config['gce']['bucket']
    @redis = ENV['REDIS_URL'] || config['redis']['url']
  end
end
