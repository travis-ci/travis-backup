$: << 'lib'
require 'uri'
require 'backup'
require 'models/repository'
require 'models/build'
require 'models/job'
require 'support/factories'
require 'pry'

describe Backup do
  before(:all) do
    system("psql '#{Config.new.database_url}' -f db/schema.sql > /dev/null")
  end

  let!(:config) { Config.new }
  let(:files_location) { "dump/tests" }
  let!(:backup) { Backup.new(files_location: files_location) }
  let(:datetime) { (config.delay + 1).months.ago.to_time.utc }
  let(:org_id) { rand(100000) }
  let(:com_id) { rand(100000) }
  let(:private_org_id) { rand(100000) }
  let(:private_com_id) { rand(100000) }
  let(:repository) {
    FactoryBot.create(
      :repository
    )
  }
  let(:build) {
    FactoryBot.create(
      :build,
      created_at: datetime,
      updated_at: datetime,
      repository: repository
    )
  }
  let(:job) {
    FactoryBot.create(
      :job,
      created_at: datetime,
      updated_at: datetime,
      source_id: build.id,
      source_type: 'Build',
      repository: repository
    )
  }

  describe 'process_repo' do
    let(:exported_object) {
      [[{"id"=>build.id,
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
        :jobs=>
          [{"id"=>job.id,
            "repository_id"=>repository.id,
            "commit_id"=>nil,
            "source_id"=>build.id,
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
      }]]
    }

    before do
      build.jobs = [job]
      repository.builds = [build]
    end

    shared_context 'removing builds and jobs' do
      it 'should delete build' do
        expect do
          backup.process_repo(repository)
        end.to change { Build.count }.by(-1)
      end

      it 'should delete job' do
        expect do
          backup.process_repo(repository)
        end.to change { Job.count }.by(-1)
      end
    end

    context 'when if_backup config is set to true' do
      it 'should prepare proper JSON export' do
        build_export = backup.process_repo(repository)
        build_export.first.first[:updated_at] = datetime
        build_export.first.first[:jobs].first[:updated_at] = datetime
        expect(build_export.to_json).to eq(exported_object.to_json)
      end

      it 'should save JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        backup.process_repo(repository)
      end

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:backup) { Backup.new(files_location: random_files_location) }

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          backup.process_repo(repository)
        end
      end

      it_behaves_like 'removing builds and jobs'
    end

    context 'when if_backup config is set to false' do
      let!(:backup) { Backup.new(if_backup: false) }

      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        backup.process_repo(repository)
      end

      it_behaves_like 'removing builds and jobs'
    end
  end
end
