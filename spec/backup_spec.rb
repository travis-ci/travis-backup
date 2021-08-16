$: << 'lib'
require 'backup'
require 'models/repository'
require 'support/factories'
require 'pry'

describe Backup do
  let!(:config) { Config.new }
  let!(:backup) { Backup.new }
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
  let(:private_repository) {
    FactoryBot.create(
      :repository,
      private: true
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
  let(:private_build) {
    FactoryBot.create(
      :build,
      created_at: datetime,
      updated_at: datetime,
      repository: private_repository
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
  let(:private_job) {
    FactoryBot.create(
      :job,
      created_at: datetime,
      updated_at: datetime,
      source_id: private_build.id,
      source_type: 'Build',
      repository: private_repository
    )
  }
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
    private_build.jobs = [private_job]
    private_repository.builds = [private_build]
  end

  it 'should prepare proper JSON export' do
    build_export = backup.process_repo(repository)
    build_export.first.first[:updated_at] = datetime
    build_export.first.first[:jobs].first[:updated_at] = datetime
    expect(build_export.to_json).to eq(exported_object.to_json)
  end
end
