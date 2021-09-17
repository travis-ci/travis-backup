# frozen_string_literal: true

class DbHelper
  def initialize(config)
    @config = config
    connect_db
  end

  def connect_db(config_or_url=@config.database_url)
    ActiveRecord::Base.establish_connection(config_or_url)
  end

  def do_in_other_db(config_or_url)
    saved_config = ActiveRecord::Base.connection_db_config
    connect_db(config_or_url)
    result = yield
    connect_db(saved_config)
    result
  end
end