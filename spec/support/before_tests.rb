class BeforeTests
  def run
    config = Config.new
    system("psql '#{config.database_url}' -f db/schema.sql > /dev/null 2> /dev/null")
    if config.destination_db_url
      system("psql '#{config.destination_db_url}' -f db/schema.sql > /dev/null 2> /dev/null")
    end
  end
end

ARGV = ['-t', '6']
