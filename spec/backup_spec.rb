$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'

require 'support/factories'
require 'support/expected_files'
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
    after(:all) do
      Repository.destroy_all
      Build.destroy_all
      Job.destroy_all
      Branch.destroy_all
      Tag.destroy_all
      Commit.destroy_all
      Cron.destroy_all
      PullRequest.destroy_all
      Request.destroy_all
      Stage.destroy_all
    end

    let!(:data) {
      ActiveRecord::Base.connection.execute('alter table repositories disable trigger all;')
      FactoryBot.create_list(:repository, 2)
      FactoryBot.create_list(:build, 2)
      FactoryBot.create_list(:job, 2)
      FactoryBot.create_list(:branch, 2)
      FactoryBot.create_list(:tag, 2)
      FactoryBot.create_list(:commit, 2)
      FactoryBot.create_list(:cron, 2)
      FactoryBot.create_list(:pull_request, 2)
      FactoryBot.create_list(:request, 2)
      FactoryBot.create_list(:stage, 2)
      FactoryBot.create_list(:repository_orphaned_on_current_build_id, 2)
      FactoryBot.create_list(:repository_with_current_build_id, 2)
      FactoryBot.create_list(:repository_orphaned_on_last_build_id, 2)
      FactoryBot.create_list(:repository_with_last_build_id, 2)
      FactoryBot.create_list(:build_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:build_with_repository_id, 2)
      FactoryBot.create_list(:build_orphaned_on_commit_id, 2)
      FactoryBot.create_list(:build_with_commit_id, 2)
      FactoryBot.create_list(:build_orphaned_on_request_id, 2)
      FactoryBot.create_list(:build_with_request_id, 2)
      FactoryBot.create_list(:build_orphaned_on_pull_request_id, 2)
      FactoryBot.create_list(:build_with_pull_request_id, 2)
      FactoryBot.create_list(:build_orphaned_on_branch_id, 2)
      FactoryBot.create_list(:build_with_branch_id, 2)
      FactoryBot.create_list(:build_orphaned_on_tag_id, 2)
      FactoryBot.create_list(:build_with_tag_id, 2)
      FactoryBot.create_list(:job_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:job_with_repository_id, 2)
      FactoryBot.create_list(:job_orphaned_on_commit_id, 2)
      FactoryBot.create_list(:job_with_commit_id, 2)
      FactoryBot.create_list(:job_orphaned_on_stage_id, 2)
      FactoryBot.create_list(:job_with_stage_id, 2)
      FactoryBot.create_list(:branch_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:branch_orphaned_on_last_build_id, 2)
      FactoryBot.create_list(:branch_with_last_build_id, 2)
      FactoryBot.create_list(:tag_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:tag_with_repository_id, 2)
      FactoryBot.create_list(:tag_orphaned_on_last_build_id, 2)
      FactoryBot.create_list(:tag_with_last_build_id, 2)
      FactoryBot.create_list(:commit_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:commit_with_repository_id, 2)
      FactoryBot.create_list(:commit_orphaned_on_branch_id, 2)
      FactoryBot.create_list(:commit_with_branch_id, 2)
      FactoryBot.create_list(:commit_orphaned_on_tag_id, 2)
      FactoryBot.create_list(:commit_with_tag_id, 2)
      FactoryBot.create_list(:cron_orphaned_on_branch_id, 2)
      FactoryBot.create_list(:cron_with_branch_id, 2)
      FactoryBot.create_list(:pull_request_orphaned_on_repository_id, 2)
      FactoryBot.create_list(:pull_request_with_repository_id, 2)
      FactoryBot.create_list(:request_orphaned_on_commit_id, 2)
      FactoryBot.create_list(:request_with_commit_id, 2)
      FactoryBot.create_list(:request_orphaned_on_pull_request_id, 2)
      FactoryBot.create_list(:request_with_pull_request_id, 2)
      FactoryBot.create_list(:request_orphaned_on_branch_id, 2)
      FactoryBot.create_list(:request_with_branch_id, 2)
      FactoryBot.create_list(:request_orphaned_on_tag_id, 2)
      FactoryBot.create_list(:request_with_tag_id, 2)
      FactoryBot.create_list(:stage_orphaned_on_build_id, 2)
      FactoryBot.create_list(:stage_with_build_id, 2)
      ActiveRecord::Base.connection.execute('alter table repositories enable trigger all;')
    }
    it 'removes orphaned repositories' do
      expect {
        backup.remove_orphans
      }.to change { Repository.all.size }.by -4
    end

    it 'removes orphaned builds' do
      expect {
        backup.remove_orphans
      }.to change { Build.all.size }.by -12
    end

    it 'removes orphaned jobs' do
      expect {
        backup.remove_orphans
      }.to change { Job.all.size }.by -6
    end

    it 'removes orphaned branches' do
      expect {
        backup.remove_orphans
      }.to change { Branch.all.size }.by -4
    end

    it 'removes orphaned tags' do
      expect {
        backup.remove_orphans
      }.to change { Tag.all.size }.by -4
    end

    it 'removes orphaned commits' do
      expect {
        backup.remove_orphans
      }.to change { Commit.all.size }.by -6
    end

    it 'removes orphaned crons' do
      expect {
        backup.remove_orphans
      }.to change { Cron.all.size }.by -2
    end

    it 'removes orphaned pull requests' do
      expect {
        backup.remove_orphans
      }.to change { PullRequest.all.size }.by -2
    end

    it 'removes orphaned requests' do
      expect {
        backup.remove_orphans
      }.to change { Request.all.size }.by -8
    end

    it 'removes orphaned stages' do
      expect {
        backup.remove_orphans
      }.to change { Stage.all.size }.by -2
    end
  end

  describe 'run' do
    after(:each) do
      Organization.destroy_all
      User.destroy_all
      Repository.destroy_all
      Build.destroy_all
      Job.destroy_all
      Log.destroy_all
      Request.destroy_all
    end

    let!(:unassigned_repositories) {
      FactoryBot.create_list(:repository_with_requests, 3)
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

    context 'when no id arguments are given' do
      it 'processes every repository' do
        Repository.all.each do |repository|
          expect(backup).to receive(:process_repo_builds).once.with(repository)
        end
        backup.run
      end
    end

    context 'when user_id is given' do
      it 'processes only the repositories of the given user' do
        processed_repos_ids = []
        allow(backup).to receive(:process_repo_builds) {|repo| processed_repos_ids.push(repo.id)}
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
        allow(backup).to receive(:process_repo_builds) {|repo| processed_repos_ids.push(repo.id)}
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
        expect(backup).to receive(:process_repo_builds).once.with(repo)
        backup.run(repo_id: repo.id)
      end
    end

    context 'when threshold is not given' do
      context 'when user_id is given' do
        it 'removes the user with all dependencies' do

        end
      end

      context 'when org_id is given' do
        it 'removes the organisation with all dependencies' do

        end
      end

      context 'when repo_id is given' do
        it 'removes the repo with all dependencies' do

        end
      end
    end

    context 'when move logs mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 5, move_logs: true) }

      it 'does not process repositories' do
        expect(backup).not_to receive(:process_repo)
        backup.run
      end

      it 'moves logs' do
        expect(backup).to receive(:move_logs).once
        backup.run
      end
    end

    context 'when remove orphans mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 5, remove_orphans: true) }

      it 'does not process repositories' do
        expect(backup).not_to receive(:process_repo)
        backup.run
      end

      it 'removes orphans' do
        expect(backup).to receive(:remove_orphans).once
        backup.run
      end
    end

    context 'when dry run mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 10, dry_run: true, threshold: 0) }

      before do
        allow_any_instance_of(IO).to receive(:puts)
      end

      it 'prepares proper dry run report' do
        backup.run
        expect(backup.dry_run_report[:builds].size).to eql 24
        expect(backup.dry_run_report[:jobs].size).to eql 48
        expect(backup.dry_run_report[:logs].size).to eql 96
        expect(backup.dry_run_report[:requests].size).to eql 6
      end

      it 'prints dry run report' do
        expect(backup).to receive(:print_dry_run_report).once
        backup.run
      end
    end
  end

  describe 'process_repo' do
    let!(:repository) {
      FactoryBot.create(:repository)
    }

    it 'processes repository builds' do
      expect(backup).to receive(:process_repo_builds).once.with(repository)
      backup.process_repo(repository)
    end

    it 'processes repository requests' do
      expect(backup).to receive(:process_repo_requests).once.with(repository)
      backup.process_repo(repository)
    end
  end

  describe 'process_repo_builds' do
    after(:each) do
      Repository.destroy_all
      Build.destroy_all
      Job.destroy_all
      Log.destroy_all
    end

    let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }
    let!(:repository) {
      FactoryBot.create(
        :repository_with_builds_jobs_and_logs,
        created_at: datetime,
        updated_at: datetime
      )
    }
    let!(:repository2) {
      FactoryBot.create(
        :repository_with_builds_jobs_and_logs,
        created_at: datetime,
        updated_at: datetime,
        builds_count: 1
      )
    }


    let!(:expected_builds_json) {
      ExpectedFiles.new(repository, datetime).builds_json
    }

    shared_context 'removing builds and jobs' do
      it 'should delete all builds of the repository' do
        backup.process_repo_builds(repository)
        expect(Build.all.map(&:repository_id)).to eq([repository2.id])
      end

      it 'should delete all jobs of removed builds and leave the rest' do
        expect {
          backup.process_repo_builds(repository)
        }.to change { Job.all.size }.by -4

        build_id = Build.first.id
        expect(Job.all.map(&:source_id)).to eq([build_id, build_id])
      end

      it 'should delete all logs of removed jobs and leave the rest' do
        expect {
          backup.process_repo_builds(repository)
        }.to change { Log.all.size }.by -8

        build_id = Build.first.id
        expect(Log.all.map(&:job).map(&:source_id)).to eq(Array.new(4, build_id))
      end
    end

    shared_context 'not saving JSON to file' do
      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        backup.process_repo_builds(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it 'should prepare proper JSON export' do
        result = backup.process_repo_builds(repository)
        result.first.first['updated_at'] = datetime
        result.first.second['updated_at'] = datetime
        result.first.first[:jobs].first['updated_at'] = datetime
        result.first.first[:jobs].second['updated_at'] = datetime
        result.first.second[:jobs].first['updated_at'] = datetime
        result.first.second[:jobs].second['updated_at'] = datetime
        result.first.first[:jobs].first[:logs].first['updated_at'] = datetime
        result.first.first[:jobs].first[:logs].second['updated_at'] = datetime
        result.first.first[:jobs].second[:logs].first['updated_at'] = datetime
        result.first.first[:jobs].second[:logs].second['updated_at'] = datetime
        result.first.second[:jobs].first[:logs].first['updated_at'] = datetime
        result.first.second[:jobs].first[:logs].second['updated_at'] = datetime
        result.first.second[:jobs].second[:logs].first['updated_at'] = datetime
        result.first.second[:jobs].second[:logs].second['updated_at'] = datetime

        expect(result.to_json).to eq(expected_builds_json.to_json)
      end

      it 'should save JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        backup.process_repo_builds(repository)
      end

      it_behaves_like 'removing builds and jobs'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:backup) { Backup.new(files_location: random_files_location, limit: 2) }

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          backup.process_repo_builds(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, if_backup: false) }

      it_behaves_like 'not saving JSON to file'
      it_behaves_like 'removing builds and jobs'
    end

    context 'when dry_run config is set to true' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, dry_run: true) }

      it_behaves_like 'not saving JSON to file'

      it 'should not delete builds' do
        expect {
          backup.process_repo_builds(repository)
        }.not_to change { Build.all.size }
      end

      it 'should not delete jobs' do
        expect {
          backup.process_repo_builds(repository)
        }.not_to change { Job.all.size }
      end
    end
  end

  describe 'process_repo_requests' do
    after(:each) do
      Repository.destroy_all
      Request.destroy_all
    end

    let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }
    let!(:repository) {
      FactoryBot.create(
        :repository_with_requests,
        created_at: datetime,
        updated_at: datetime
      )
    }
    let!(:repository2) {
      FactoryBot.create(
        :repository_with_requests,
        created_at: datetime,
        updated_at: datetime,
        requests_count: 1
      )
    }


    let!(:expected_requests_json) {
      ExpectedFiles.new(repository, datetime).requests_json
    }

    shared_context 'removing requests' do
      it 'should delete all requests of the repository' do
        backup.process_repo_requests(repository)
        expect(Request.all.map(&:repository_id)).to eq([repository2.id])
      end
    end

    shared_context 'not saving JSON to file' do
      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        backup.process_repo_requests(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it 'should prepare proper JSON export' do
        result = backup.process_repo_requests(repository)
        expect(result.to_json).to eq(expected_requests_json.to_json)
      end

      it 'should save JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        backup.process_repo_requests(repository)
      end

      it_behaves_like 'removing requests'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:backup) { Backup.new(files_location: random_files_location, limit: 2) }

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          backup.process_repo_requests(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, if_backup: false) }

      it_behaves_like 'not saving JSON to file'
      it_behaves_like 'removing requests'
    end

    context 'when dry_run config is set to true' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 2, dry_run: true) }

      it_behaves_like 'not saving JSON to file'

      it 'should not delete requests' do
        expect {
          backup.process_repo_requests(repository)
        }.not_to change { Request.all.size }
      end
    end
  end
end
