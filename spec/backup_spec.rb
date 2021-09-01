$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/repository'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'pry'

describe Backup do
  before(:all) do
    ARGV = ['-t', '6']
    config = Config.new
    system("psql '#{config.database_url}' -f db/schema.sql > /dev/null")
    system("psql '#{config.destination_db_url}' -f db/schema.sql > /dev/null") if config.destination_db_url
  end

  let(:files_location) { "dump/tests" }
  let!(:backup) { Backup.new(files_location: files_location, limit: 5) }

  describe 'move_logs' do
    let!(:logs) {
      (1..10).to_a.map do
        FactoryBot.create(:log)    
      end
    }

    def connect_db(url)
      ActiveRecord::Base.establish_connection(url)
    end

    def do_in_destination_db(config)
      connect_db(config.destination_db_url)
      result = yield
      connect_db(config.database_url)
      result
    end

    it 'copies logs to destination database' do
      def destination_logs_size
        do_in_destination_db(backup.config) do
          Log.all.size
        end
      end

      source_db_logs = Log.all.as_json

      expect {
        backup.move_logs
      }.to change { destination_logs_size }.by 10

      destination_db_logs = do_in_destination_db(backup.config) do
        Log.all.as_json
      end

      expect(destination_db_logs).to eql(source_db_logs)
    end

    it 'removes copied logs from source database' do
      expect {
        backup.move_logs
      }.to change { Log.all.size }.by -10
    end
  end

  describe 'remove_orphans' do
    let!(:repositories) {
      FactoryBot.create_list(:repository, 100_000)
    }
    let!(:repositories_with_builds) {
      FactoryBot.create_list(:repository_with_builds, 100_000)
    }
    let!(:orphan_repositories) {
      ActiveRecord::Base.connection.execute('alter table repositories disable trigger all;')
      FactoryBot.create_list(:orphan_repository, 10000)
      ActiveRecord::Base.connection.execute('alter table repositories enable trigger all;')
    }
    it 'removes orphaned repositories' do
      expect {
        start = Time.now
        backup.remove_orphans
        removing_time = Time.now - start
        puts 1
        puts removing_time

        ActiveRecord::Base.connection.execute('alter table repositories disable trigger all;')
        FactoryBot.create_list(:orphan_repository, 10000)
        ActiveRecord::Base.connection.execute('alter table repositories enable trigger all;')
        start = Time.now
        backup.remove_orphans2
        removing_time = Time.now - start
        puts 2
        puts removing_time

        ActiveRecord::Base.connection.execute('alter table repositories disable trigger all;')
        FactoryBot.create_list(:orphan_repository, 10000)
        ActiveRecord::Base.connection.execute('alter table repositories enable trigger all;')
        start = Time.now
        backup.remove_orphans3
        removing_time = Time.now - start
        puts 3
        puts removing_time

        ActiveRecord::Base.connection.execute('alter table repositories disable trigger all;')
        FactoryBot.create_list(:orphan_repository, 10000)
        ActiveRecord::Base.connection.execute('alter table repositories enable trigger all;')
        start = Time.now
        backup.remove_orphans4
        removing_time = Time.now - start
        puts 4
        puts removing_time

      }.to change { Repository.all.size }.by -10000
    end
  end

  describe 'run' do
    let!(:unassigned_repositories) {
      (1..3).to_a.map do
        FactoryBot.create(:repository)    
      end
    }
    let!(:user1) {
      FactoryBot.create(:user_with_repos)
    }
    let!(:user2) {
      FactoryBot.create(:user_with_repos)
    }
    let!(:organization1) {
      FactoryBot.create(:organization_with_repos)
    }
    let!(:organization2) {
      FactoryBot.create(:organization_with_repos)
    }

    context 'when no arguments are given' do
      it 'processes every repository' do
        Repository.all.each do |repository|
          expect(backup).to receive(:process_repo).once.with(repository)
        end
        backup.run
      end
    end

    context 'when user_id is given' do
      it 'processes only the repositories of the given user' do
        processed_repos_ids = []
        allow(backup).to receive(:process_repo) {|repo| processed_repos_ids.push(repo.id)}
        user_repos_ids = Repository.where(
          'owner_id = ? and owner_type = ?',
          user1.id,
          'User'
        ).map(&:id)
        backup.run(user_id: user1.id)
        expect(processed_repos_ids).to match_array(user_repos_ids)
      end
    end

    context 'when org_id is given' do
      it 'processes only the repositories of the given organization' do
        processed_repos_ids = []
        allow(backup).to receive(:process_repo) {|repo| processed_repos_ids.push(repo.id)}
        organization_repos_ids = Repository.where(
          'owner_id = ? and owner_type = ?',
          organization1.id,
          'Organization'
        ).map(&:id)
        backup.run(org_id: organization1.id)
        expect(processed_repos_ids).to match_array(organization_repos_ids)
      end
    end

    context 'when repo_id is given' do
      it 'processes only the repository with the given id' do
        repo = Repository.first
        expect(backup).to receive(:process_repo).once.with(repo)
        backup.run(repo_id: repo.id)
      end
    end

    context 'when move logs mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 5, move_logs: true) }

      it 'does not process repositories' do
        repo = Repository.first
        expect(backup).not_to receive(:process_repo)
        backup.run
      end

      it 'moves logs' do
        repo = Repository.first
        expect(backup).to receive(:move_logs).once
        backup.run
      end
    end
  end

  describe 'process_repo' do
    after(:each) do
      Repository.destroy_all
      Build.destroy_all
      Job.destroy_all
    end
  
    let!(:config) { Config.new }
    let(:datetime) { (config.threshold + 1).months.ago.to_time.utc }
    let(:org_id) { rand(100000) }
    let(:com_id) { rand(100000) }
    let(:private_org_id) { rand(100000) }
    let(:private_com_id) { rand(100000) }
    let!(:repository) {
      FactoryBot.create(
        :repository_with_builds,
        created_at: datetime,
        updated_at: datetime
      )
    }
    let!(:repository2) {
      FactoryBot.create(
        :repository_with_builds,
        created_at: datetime,
        updated_at: datetime,
        builds_count: 1
      )
    }


    let!(:exported_object) {
      [[
        {
          "id"=>repository.builds.first.id,
          "repository_id"=>repository.id,
          "number"=>nil,
          "started_at"=>nil,
          "finished_at"=>nil,
          "created_at"=>datetime,
          "updated_at"=>datetime,
          "config"=>nil,
          "commit_id"=>nil,
          "request_id"=>nil,
          "state"=>nil,
          "duration"=>nil,
          "owner_id"=>nil,
          "owner_type"=>nil,
          "event_type"=>nil,
          "previous_state"=>nil,
          "pull_request_title"=>nil,
          "pull_request_number"=>nil,
          "branch"=>nil,
          "canceled_at"=>nil,
          "cached_matrix_ids"=>nil,
          "received_at"=>nil,
          "private"=>nil,
          "pull_request_id"=>nil,
          "branch_id"=>nil,
          "tag_id"=>nil,
          "sender_id"=>nil,
          "sender_type"=>nil,
          :jobs=>[{
            "id"=>repository.builds.first.jobs.first.id,
            "repository_id"=>repository.id,
            "commit_id"=>nil,
            "source_id"=>repository.builds.first.id,
            "source_type"=>"Build",
            "queue"=>nil,
            "type"=>nil,
            "state"=>nil,
            "number"=>nil,
            "config"=>nil,
            "worker"=>nil,
            "started_at"=>nil,
            "finished_at"=>nil,
            "created_at"=>datetime,
            "updated_at"=>datetime,
            "tags"=>nil,
            "allow_failure"=>false,
            "owner_id"=>nil,
            "owner_type"=>nil,
            "result"=>nil,
            "queued_at"=>nil,
            "canceled_at"=>nil,
            "received_at"=>nil,
            "debug_options"=>nil,
            "private"=>nil,
            "stage_number"=>nil,
            "stage_id"=>nil
          },
          {
            "id"=>repository.builds.first.jobs.second.id,
            "repository_id"=>repository.id,
            "commit_id"=>nil,
            "source_id"=>repository.builds.first.id,
            "source_type"=>"Build",
            "queue"=>nil,
            "type"=>nil,
            "state"=>nil,
            "number"=>nil,
            "config"=>nil,
            "worker"=>nil,
            "started_at"=>nil,
            "finished_at"=>nil,
            "created_at"=>datetime,
            "updated_at"=>datetime,
            "tags"=>nil,
            "allow_failure"=>false,
            "owner_id"=>nil,
            "owner_type"=>nil,
            "result"=>nil,
            "queued_at"=>nil,
            "canceled_at"=>nil,
            "received_at"=>nil,
            "debug_options"=>nil,
            "private"=>nil,
            "stage_number"=>nil,
            "stage_id"=>nil
          }]
        },
        {
          "id"=>repository.builds.second.id,
          "repository_id"=>repository.id,
          "number"=>nil,
          "started_at"=>nil,
          "finished_at"=>nil,
          "created_at"=>datetime,
          "updated_at"=>datetime,
          "config"=>nil,
          "commit_id"=>nil,
          "request_id"=>nil,
          "state"=>nil,
          "duration"=>nil,
          "owner_id"=>nil,
          "owner_type"=>nil,
          "event_type"=>nil,
          "previous_state"=>nil,
          "pull_request_title"=>nil,
          "pull_request_number"=>nil,
          "branch"=>nil,
          "canceled_at"=>nil,
          "cached_matrix_ids"=>nil,
          "received_at"=>nil,
          "private"=>nil,
          "pull_request_id"=>nil,
          "branch_id"=>nil,
          "tag_id"=>nil,
          "sender_id"=>nil,
          "sender_type"=>nil,
          :jobs=>[{
            "id"=>repository.builds.second.jobs.first.id,
            "repository_id"=>repository.id,
            "commit_id"=>nil,
            "source_id"=>repository.builds.second.id,
            "source_type"=>"Build",
            "queue"=>nil,
            "type"=>nil,
            "state"=>nil,
            "number"=>nil,
            "config"=>nil,
            "worker"=>nil,
            "started_at"=>nil,
            "finished_at"=>nil,
            "created_at"=>datetime,
            "updated_at"=>datetime,
            "tags"=>nil,
            "allow_failure"=>false,
            "owner_id"=>nil,
            "owner_type"=>nil,
            "result"=>nil,
            "queued_at"=>nil,
            "canceled_at"=>nil,
            "received_at"=>nil,
            "debug_options"=>nil,
            "private"=>nil,
            "stage_number"=>nil,
            "stage_id"=>nil
          },
          {
            "id"=>repository.builds.second.jobs.second.id,
            "repository_id"=>repository.id,
            "commit_id"=>nil,
            "source_id"=>repository.builds.second.id,
            "source_type"=>"Build",
            "queue"=>nil,
            "type"=>nil,
            "state"=>nil,
            "number"=>nil,
            "config"=>nil,
            "worker"=>nil,
            "started_at"=>nil,
            "finished_at"=>nil,
            "created_at"=>datetime,
            "updated_at"=>datetime,
            "tags"=>nil,
            "allow_failure"=>false,
            "owner_id"=>nil,
            "owner_type"=>nil,
            "result"=>nil,
            "queued_at"=>nil,
            "canceled_at"=>nil,
            "received_at"=>nil,
            "debug_options"=>nil,
            "private"=>nil,
            "stage_number"=>nil,
            "stage_id"=>nil
          }]
        }
      ]]
    }

    shared_context 'removing builds and jobs' do
      it 'should delete all builds of the repository' do
        backup.process_repo(repository)
        expect(Build.all.map(&:repository_id)).to eq([repository2.id])
      end

      it 'should delete all jobs of removed builds and leave the rest' do
        backup.process_repo(repository)
        build_id = Build.first.id
        expect(Job.all.map(&:source_id)).to eq([build_id, build_id])
      end
    end

    context 'when if_backup config is set to true' do
      it 'should prepare proper JSON export' do
        build_export = backup.process_repo(repository)
        build_export.first.first['updated_at'] = datetime
        build_export.first.second['updated_at'] = datetime
        build_export.first.first[:jobs].first['updated_at'] = datetime
        build_export.first.first[:jobs].second['updated_at'] = datetime
        build_export.first.second[:jobs].first['updated_at'] = datetime
        build_export.first.second[:jobs].second['updated_at'] = datetime

        expect(build_export.to_json).to eq(exported_object.to_json)
      end

      it 'should save JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        backup.process_repo(repository)
      end

      it_behaves_like 'removing builds and jobs'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:backup) { Backup.new(files_location: random_files_location, limit: 2) }

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          backup.process_repo(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, if_backup: false) }

      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        backup.process_repo(repository)
      end

      it_behaves_like 'removing builds and jobs'
    end

    context 'when dry_run config is set to true' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, dry_run: true) }

      before do
        allow_any_instance_of(IO).to receive(:puts)
      end

      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        backup.process_repo(repository)
      end

      it 'should not delete builds' do
        expect {
          backup.process_repo(repository)
        }.not_to change { Build.all.size }
      end

      it 'should not delete jobs' do
        expect {
          backup.process_repo(repository)
        }.not_to change { Job.all.size }
      end
    end
  end
end
