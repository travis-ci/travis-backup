class BeforeTests
  def run
    config = Config.new
    helper = DbHelper.new(config)
    truncate_all_tables
    helper.do_in_other_db(config.destination_db_url) do
      truncate_all_tables
    end
  end

  def truncate_all_tables
    sql = File.read('db/schema.sql')
    ActiveRecord::Base.connection.execute(sql)
  end
end

ARGV = ['-t', '6']
