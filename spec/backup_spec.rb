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
  let(:build_config) {
    FactoryBot.create(
      :build_config,
      repository_id: repository.id,
      key: '',
      org_id: org_id,
      com_id: com_id,
      config: ''
    )
  }
  let(:private_build_config) {
    FactoryBot.create(
      :build_config,
      repository_id: private_repository.id,
      key: '',
      org_id: private_org_id,
      com_id: private_com_id,
      config: ''
    )
  }
  let(:build) {
    FactoryBot.create(
      :build,
      created_at: datetime,
      updated_at: datetime,
      repository: repository,
      build_config: build_config
    )
  }
  let(:private_build) {
    FactoryBot.create(
      :build,
      created_at: datetime,
      updated_at: datetime,
      repository: private_repository,
      build_config: private_build_config
    )
  }
  let(:job_config) {
    FactoryBot.create(
      :job_config,
      repository_id: repository.id,
      key: '',
      org_id: org_id,
      com_id: com_id,
      config: ''
    )
  }
  let(:private_job_config) {
    FactoryBot.create(
      :job_config,
      repository_id: private_repository.id,
      key: '',
      org_id: private_org_id,
      com_id: private_com_id,
      config: ''
    )
  }
  let(:job) {
    FactoryBot.create(
      :job,
      created_at: datetime,
      updated_at: datetime,
      source_id: build.id,
      source_type: 'Build',
      repository: repository,
      job_config: job_config
    )
  }
  let(:private_job) {
    FactoryBot.create(
      :job,
      created_at: datetime,
      updated_at: datetime,
      source_id: private_build.id,
      source_type: 'Build',
      repository: private_repository,
      job_config: private_job_config
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
      "org_id"=>nil,
      "com_id"=>nil,
      "config_id"=>build_config.id,
      "restarted_at"=>nil,
      "unique_number"=>nil,
      :build_config=>{"id"=>build_config.id, "repository_id"=>repository.id, "key"=>"", "org_id"=>org_id, "com_id"=>com_id, "config"=>""},
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
         "job_state_id"=>nil,
         "stage_number"=>nil,
         "stage_id"=>nil,
         "org_id"=>nil,
         "com_id"=>nil,
         "config_id"=>job_config.id,
         "restarted_at"=>nil,
         "priority"=>nil,
         :job_config=>{"id"=>job_config.id, "repository_id"=>repository.id, "key"=>"", "org_id"=>org_id, "com_id"=>com_id, "config"=>""},
         :log_url=>"https://api.travis-ci.org/v3/job/#{job.id}/log.txt"}]}]]
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

  it 'for private repository should prepare proper JSON export with token for log urls' do
    build_export = backup.process_repo(private_repository)
    log_url = build_export.first.first[:jobs].first[:log_url]
    expect(log_url).to include('?log.token=')
  end
end
