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
require 'support/utils'
require 'pry'


describe Backup::RemoveOld do
  before(:all) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:config) { Config.new(files_location: files_location, limit: 5) }
  let!(:db_helper) { DbHelper.new(config) }
  let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

  
  describe 'process_repo' do
    let!(:repository) {
      FactoryBot.create(:repository)
    }

    it 'processes repository builds' do
      expect(remove_old).to receive(:process_repo_builds).once.with(repository)
      remove_old.process_repo(repository)
    end

    it 'processes repository requests' do
      expect(remove_old).to receive(:process_repo_requests).once.with(repository)
      remove_old.process_repo(repository)
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
      ActiveRecord::Base.connection.execute('set session_replication_role = replica;')
      repository = FactoryBot.create(
        :repository_with_builds_jobs_and_logs,
        created_at: datetime,
        updated_at: datetime
      )
      ActiveRecord::Base.connection.execute('set session_replication_role = default;')
      repository
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
      ExpectedFiles.new(repository, datetime)
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
      it 'should delete all builds of the repository' do
        remove_old.process_repo_builds(repository)
        expect(Build.all.map(&:repository_id)).to eq([repository2.id])
      end

      it 'should delete all jobs of removed builds and leave the rest' do
        expect {
          remove_old.process_repo_builds(repository)
        }.to change { Job.all.size }.by -4

        build_id = Build.first.id
        expect(Job.all.map(&:source_id)).to eq([build_id, build_id])
      end

      it 'should delete all logs of removed jobs and leave the rest' do
        expect {
          remove_old.process_repo_builds(repository)
        }.to change { Log.all.size }.by -8

        build_id = Build.first.id
        expect(Log.all.map(&:job).map(&:source_id)).to eq(Array.new(4, build_id))
      end
    end

    shared_context 'not saving JSON to file' do
      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        remove_old.process_repo_builds(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it 'should save proper build JSON file' do
        expect_method_calls_on(
          File, :write,
          [JSON.pretty_generate(expected_builds_json)],
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_old.process_repo_builds(repository)
        end
      end

      it 'should save proper job JSON files' do
        expect_method_calls_on(
          File, :write,
          [
            JSON.pretty_generate(expected_jobs_jsons.first),
            JSON.pretty_generate(expected_jobs_jsons.second)
          ],
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_old.process_repo_builds(repository)
        end
      end

      it 'should save proper log JSON files' do
        expect_method_calls_on(
          File, :write,
          [
            JSON.pretty_generate(expected_logs_jsons.first),
            JSON.pretty_generate(expected_logs_jsons.second),
            JSON.pretty_generate(expected_logs_jsons.third),
            JSON.pretty_generate(expected_logs_jsons.fourth),
          ],
          allow_instances: true,
          arguments_to_check: :first
        ) do
          remove_old.process_repo_builds(repository)
        end
      end

      it 'should save JSON files at proper paths' do
        expect_method_calls_on(
          File, :open,
          [
            Regexp.new('dump/tests/repository_\d+_build_\d+_job_\d+_logs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_build_\d+_job_\d+_logs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_build_\d+_jobs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_build_\d+_job_\d+_logs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_build_\d+_job_\d+_logs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_build_\d+_jobs_\d+-\d+.json'),
            Regexp.new('dump/tests/repository_\d+_builds_\d+-\d+.json')
          ],
          match_mode: :match,
          arguments_to_check: :first
        ) do
          remove_old.process_repo_builds(repository)
        end
      end

      it_behaves_like 'removing builds and jobs'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:config) { Config.new(files_location: random_files_location, limit: 2) }
        let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }
      

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          remove_old.process_repo_builds(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, if_backup: false) }
      let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving JSON to file'
      it_behaves_like 'removing builds and jobs'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving JSON to file'

      it 'should not delete builds' do
        expect {
          remove_old.process_repo_builds(repository)
        }.not_to change { Build.all.size }
      end

      it 'should not delete jobs' do
        expect {
          remove_old.process_repo_builds(repository)
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
        remove_old.process_repo_requests(repository)
        expect(Request.all.map(&:repository_id)).to eq([repository2.id])
      end
    end

    shared_context 'not saving JSON to file' do
      it 'should not save JSON to file' do
        expect(File).not_to receive(:open)
        remove_old.process_repo_requests(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it 'should save proper build JSON to file' do
        expect_any_instance_of(File).to receive(:write).once.with(JSON.pretty_generate(expected_requests_json))
        remove_old.process_repo_requests(repository)
      end

      it 'should save JSON to file at proper path' do
        expect(File).to receive(:open).once.with(Regexp.new(files_location), 'w')
        remove_old.process_repo_requests(repository)
      end

      it_behaves_like 'removing requests'

      context 'when path with nonexistent folders is given' do
        let(:random_files_location) { "dump/tests/#{rand(100000)}" }
        let!(:config) { Config.new(files_location: random_files_location, limit: 2) }
        let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

        it 'should create needed folders' do
          expect(FileUtils).to receive(:mkdir_p).once.with(random_files_location).and_call_original
          remove_old.process_repo_requests(repository)
        end
      end
    end

    context 'when if_backup config is set to false' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, if_backup: false) }
      let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving JSON to file'
      it_behaves_like 'removing requests'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_old) { Backup::RemoveOld.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving JSON to file'

      it 'should not delete requests' do
        expect {
          remove_old.process_repo_requests(repository)
        }.not_to change { Request.all.size }
      end
    end
  end
end
