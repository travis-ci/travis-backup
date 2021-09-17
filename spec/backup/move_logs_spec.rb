$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'support/expected_files'
require 'support/before_tests'
require 'pry'


describe Backup::MoveLogs do
  before(:all) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:config) { Config.new(files_location: files_location, limit: 5) }
  let!(:db_helper) { DbHelper.new(config) }
  let!(:move_logs) { Backup::MoveLogs.new(config, db_helper, DryRunReporter.new) }

  describe 'run' do
    let!(:logs) {
      FactoryBot.create_list(
        :log,
        10,
        job_id: 1,
        content: 'some log content',
        removed_by: 1,
        archiving: false,
        archive_verified: true
      )    
    }

    def do_in_destination_db(&block)
      db_helper.do_in_other_db(config.destination_db_url, &block)
    end

    def destination_logs_size
      do_in_destination_db do
        Log.all.size
      end
    end

    it 'copies logs to destination database' do
      source_db_logs = Log.all.as_json

      expect {
        move_logs.run
      }.to change { destination_logs_size }.by 10

      destination_db_logs = do_in_destination_db do
        Log.all.as_json
      end

      expect(destination_db_logs).to eql(source_db_logs)
    end

    it 'removes copied logs from source database' do
      expect {
        move_logs.run
      }.to change { Log.all.size }.by -10
    end
  end
end
