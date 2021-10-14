$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'support/expected_files_provider'
require 'support/before_tests'
require 'support/utils'
require 'pry'
require 'byebug'

describe Backup::RemoveSpecified do
  def db_summary_hash
    {
      all: Model.get_sum_of_rows_of_all_models,
      logs: Log.all.size,
      jobs: Job.all.size,
      builds: Build.all.size,
      requests: Request.all.size,
      repositories: Repository.all.size,
      branches: Branch.all.size,
      tags: Tag.all.size,
      commits: Commit.all.size,
      crons: Cron.all.size,
      pull_requests: PullRequest.all.size,
      ssl_keys: SslKey.all.size,
      stages: Stage.all.size,
      stars: Star.all.size,
      permissions: Permission.all.size,
      messages: Message.all.size,
      abuses: Abuse.all.size,
      annotations: Annotation.all.size,
      queueable_jobs: QueueableJob.all.size
    }    
  end

  def get_expected_files(directory, datetime)
    Dir["spec/support/expected_files/#{directory}/*.json"].map do |file_path|
      content = File.read(file_path)
      content.gsub(/"[^"]+ UTC"/, "\"#{datetime.to_s}\"")
    end
  end

  before(:all) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:config) { Config.new(files_location: files_location, limit: 5) }
  let!(:db_helper) { DbHelper.new(config) }
  let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }
  let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }

  describe 'remove_heavy_data_for_repo' do
    let!(:repository) {
      FactoryBot.create(:repository)
    }

    it 'processes repository builds' do
      expect(remove_specified).to receive(:remove_repo_builds).once.with(repository)
      remove_specified.remove_heavy_data_for_repo(repository)
    end

    it 'processes repository requests' do
      expect(remove_specified).to receive(:remove_repo_requests).once.with(repository)
      remove_specified.remove_heavy_data_for_repo(repository)
    end
  end

  describe 'remove_repo_builds' do
    before(:each) do
      BeforeTests.new.run
    end

    after(:each) do
      Repository.destroy_all
      Build.destroy_all
      Job.destroy_all
      Log.destroy_all
    end

    let!(:repository) {
      db_helper.do_without_triggers do
        FactoryBot.create(
          :repository_with_builds_jobs_and_logs,
          created_at: datetime,
          updated_at: datetime
        )
      end
    }
    let!(:repository2) {
      FactoryBot.create(
        :repository_with_builds_jobs_and_logs,
        created_at: datetime,
        updated_at: datetime,
        builds_count: 1
      )
    }
    let(:expected_files_creator) {
      ExpectedFilesProvider.new(repository, datetime)
    }
    let!(:expected_builds_json) {
      expected_files_creator.builds_json
    }
    let!(:expected_jobs_jsons) {
      repository.builds.map do |build|
        expected_files_creator.jobs_json(build)
      end
    }
    let!(:expected_logs_jsons) {
      repository.builds.map do |build|
        build.jobs.map do |job|
          expected_files_creator.logs_json(job)
        end
      end.flatten(1)
    }

    shared_context 'removing builds and jobs' do
      it 'deletes all builds of the repository' do
        remove_specified.remove_repo_builds(repository)
        expect(Build.all.map(&:repository_id)).to eq([repository2.id])
      end

      it 'deletes all jobs of removed builds and leaves the rest' do
        expect {
          remove_specified.remove_repo_builds(repository)
        }.to change { Job.all.size }.by -4

        build_id = Build.first.id
        expect(Job.all.map(&:source_id)).to eq([build_id, build_id])
      end

      it 'deletes all logs of removed jobs and leaves the rest' do
        expect {
          remove_specified.remove_repo_builds(repository)
        }.to change { Log.all.size }.by -8

        build_id = Build.first.id
        expect(Log.all.map(&:job).map(&:source_id)).to eq(Array.new(4, build_id))
      end
    end

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_repo_builds(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it_behaves_like 'removing builds and jobs'

      it 'saves removed data to files in proper format' do
        expect_method_calls_on(
          File, :write,
          get_expected_files('remove_repo_builds', datetime),
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_specified.remove_repo_builds(repository)
        end
      end

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:config) { Config.new(files_location: random_files_location, limit: 2) }
        let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }
      
        it 'creates needed folders' do
          path_regexp = Regexp.new("#{random_files_location}/.+")
          expect(FileUtils).to receive(:mkdir_p).once.with(path_regexp).and_call_original
          remove_specified.remove_repo_builds(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, if_backup: false) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'
      it_behaves_like 'removing builds and jobs'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_repo_builds(repository)
        }.not_to change { Model.get_sum_of_rows_of_all_models }
      end
    end
  end

  describe 'remove_repo_requests' do
    before(:each) do
      BeforeTests.new.run
    end

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
      ExpectedFilesProvider.new(repository, datetime).requests_json
    }

    shared_context 'removing requests' do
      it 'deletes all requests of the repository' do
        remove_specified.remove_repo_requests(repository)
        expect(Request.all.map(&:repository_id)).to eq([repository2.id])
      end
    end

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_repo_requests(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it 'saves removed data to files in proper format' do
        expect_method_calls_on(
          File, :write,
          get_expected_files('remove_repo_requests', datetime),
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_specified.remove_repo_requests(repository)
        end
      end

      it 'saves JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        remove_specified.remove_repo_requests(repository)
      end

      it_behaves_like 'removing requests'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:config) { Config.new(files_location: random_files_location, limit: 2) }
        let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

        it 'creates needed folders' do
          path_regexp = Regexp.new("#{random_files_location}/.+")
          expect(FileUtils).to receive(:mkdir_p).once.with(path_regexp).and_call_original
          remove_specified.remove_repo_requests(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, if_backup: false) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'
      it_behaves_like 'removing requests'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_repo_requests(repository)
        }.not_to change { Model.get_sum_of_rows_of_all_models }
      end
    end
  end

  describe 'remove_user_with_dependencies' do
    before(:each) do
      BeforeTests.new.run
    end

    let!(:user) {
      FactoryBot.rewind_sequences

      db_helper.do_without_triggers do
        FactoryBot.create(
          :user_with_all_dependencies,
          created_at: datetime,
          updated_at: datetime
        )
      end
    }

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_user_with_dependencies(user.id)
      end
    end

    shared_context 'removing user with dependencies' do
      it 'removes user with all his dependencies with proper exceptions' do
        remove_specified.remove_user_with_dependencies(user.id)

        expect(db_summary_hash).to eql(
          all: 870,
          logs: 64,
          jobs: 134,
          builds: 90,
          requests: 40,
          repositories: 108,
          branches: 62,
          tags: 62,
          commits: 24,
          crons: 8,
          pull_requests: 8,
          ssl_keys: 8,
          stages: 54,
          stars: 8,
          permissions: 8,
          messages: 32,
          abuses: 32,
          annotations: 64,
          queueable_jobs: 64
        )
      end
    end

    it_behaves_like 'removing user with dependencies'

    context 'when if_backup config is set to true' do
      it 'saves removed data to files in proper format' do
        expect_method_calls_on(
          File, :write,
          get_expected_files('remove_user_with_dependencies', datetime),
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_specified.remove_user_with_dependencies(user.id)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, if_backup: false) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'
      it_behaves_like 'removing user with dependencies'
    end


    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_user_with_dependencies(user.id)
        }.not_to change { Model.get_sum_of_rows_of_all_models }
      end
    end
  end

  describe 'remove_org_with_dependencies' do
    before(:each) do
      BeforeTests.new.run
    end

    let!(:organization) {
      FactoryBot.rewind_sequences

      db_helper.do_without_triggers do
        FactoryBot.create(
          :organization_with_all_dependencies,
          created_at: datetime,
          updated_at: datetime
        )
      end
    }

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_org_with_dependencies(organization.id)
      end
    end

    shared_context 'removing organization with dependencies' do
      it 'removes organization with all its dependencies with proper exceptions' do
        remove_specified.remove_org_with_dependencies(organization.id)

        expect(db_summary_hash).to eql(
          all: 870,
          logs: 64,
          jobs: 134,
          builds: 90,
          requests: 40,
          repositories: 108,
          branches: 62,
          tags: 62,
          commits: 24,
          crons: 8,
          pull_requests: 8,
          ssl_keys: 8,
          stages: 54,
          stars: 8,
          permissions: 8,
          messages: 32,
          abuses: 32,
          annotations: 64,
          queueable_jobs: 64
        )
      end
    end

    it_behaves_like 'removing organization with dependencies'

    context 'when if_backup config is set to true' do
      it 'saves removed data to files in proper format' do
        expect_method_calls_on(
          File, :write,
          get_expected_files('remove_org_with_dependencies', datetime),
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_specified.remove_org_with_dependencies(organization.id)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, if_backup: false) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'
      it_behaves_like 'removing organization with dependencies'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_org_with_dependencies(organization.id)
        }.not_to change { Model.get_sum_of_rows_of_all_models }
      end
    end
  end

  describe 'remove_repo_with_dependencies' do
    before(:each) do
      BeforeTests.new.run
    end

    let!(:repository) {
      FactoryBot.rewind_sequences

      db_helper.do_without_triggers do
        FactoryBot.create(
          :repository_with_all_dependencies,
          created_at: datetime,
          updated_at: datetime
        )
      end
    }

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_repo_with_dependencies(repository.id)
      end
    end

    shared_context 'removing repository with dependencies' do
      it 'removes repository with all its dependencies with proper exceptions' do
        remove_specified.remove_repo_with_dependencies(repository.id)

        expect(db_summary_hash).to eql(
          all: 470,
          logs: 32,
          jobs: 72,
          builds: 50,
          requests: 20,
          repositories: 64,
          branches: 36,
          tags: 36,
          commits: 12,
          crons: 4,
          pull_requests: 4,
          ssl_keys: 4,
          stages: 32,
          stars: 4,
          permissions: 4,
          messages: 16,
          abuses: 16,
          annotations: 32,
          queueable_jobs: 32
        )
      end
    end

    it_behaves_like 'removing repository with dependencies'

    context 'when if_backup config is set to true' do
      it 'saves removed data to files in proper format' do
        expect_method_calls_on(
          File, :write,
          get_expected_files('remove_repo_with_dependencies', datetime),
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_specified.remove_repo_with_dependencies(repository.id)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, if_backup: false) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'
      it_behaves_like 'removing repository with dependencies'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_repo_with_dependencies(repository.id)
        }.not_to change { Model.get_sum_of_rows_of_all_models }
      end
    end
  end
end
