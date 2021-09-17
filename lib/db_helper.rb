# frozen_string_literal: true

class DbHelper
  def initialize(config)
    @config = config
    connect_db
  end

  def connect_db(url=@config.database_url)
    ActiveRecord::Base.establish_connection(url)
  end
end