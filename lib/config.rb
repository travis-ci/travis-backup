# frozen_string_literal: true

# Config for travis-backup
class Config
  attr_reader :if_backup, :limit, :threshold, :files_location, :database_url, :user_id, :repo_id, :org_id

  def initialize(args={}) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    config = yaml_load('config/settings.yml')
    connection_details = yaml_load('config/database.yml')

    @if_backup = first_not_nil(
      args[:if_backup],
      ENV['IF_BACKUP'],
      config.dig('backup', 'if_backup'),
      true
    )
    @limit = first_not_nil(
      args[:limit],
      ENV['BACKUP_LIMIT'],
      config.dig('backup', 'limit'),
      1000
    )
    @threshold = first_not_nil(
      args[:threshold],
      ENV['BACKUP_DELAY'],
      config.dig('backup', 'threshold'),
      6
    )
    @files_location = first_not_nil(
      args[:files_location],
      ENV['BACKUP_FILES_LOCATION'],
      config.dig('backup', 'files_location'),
      './dump'
    )
    @database_url = first_not_nil(
      args[:database_url],
      ENV['DATABASE_URL'],
      connection_details.dig(ENV['RAILS_ENV'])
    )
    @user_id = first_not_nil(
      args[:user_id],
      ENV['USER_ID'],
      config.dig('backup', 'user_id')
    )
    @repo_id = first_not_nil(
      args[:repo_id],
      ENV['REPO_ID'],
      config.dig('backup', 'repo_id')
    )
    @org_id = first_not_nil(
      args[:org_id],
      ENV['ORG_ID'],
      config.dig('backup', 'org_id')
    )
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
