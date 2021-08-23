$: << 'lib'
require 'uri'
require 'tci-backup'
require 'models/repository'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'pry'

describe Backup do
  before(:all) do
    system("psql '#{Config.new.database_url}' -f db/schema.sql > /dev/null")
  end

  let(:files_location) { "dump/tests" }
  let!(:backup) { Backup.new(files_location: files_location, limit: 2) }

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

    shared_context 'removing builds and jobs in batches' do
      it 'should delete builds fitting to batches' do
        backup.process_repo(repository)
        expect(Build.all.size).to eq(1)
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

      it_behaves_like 'removing builds and jobs in batches'

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

      it_behaves_like 'removing builds and jobs in batches'
    end
  end
end
