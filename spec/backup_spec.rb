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

describe Backup do
  before(:all) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:backup) { Backup.new(files_location: files_location, limit: 5) }

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

    context 'when no arguments are given' do
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

    context 'when move logs mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 5, move_logs: true) }

      it 'does not process repositories' do
        expect(backup).not_to receive(:process_repo)
        backup.run
      end

      it 'moves logs' do
        expect_any_instance_of(Backup::MoveLogs).to receive(:run).once
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
        expect_any_instance_of(Backup::RemoveOrphans).to receive(:run).once
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
        expect_any_instance_of(DryRunReporter).to receive(:print_report).once
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
      it 'should save proper build JSON file' do
        expect_method_calls_on(
          File, :write,
          [JSON.pretty_generate(expected_builds_json)],
          allow_instances: true,
          arguments_to_check: :first
        ) do
          backup.process_repo_builds(repository)
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
          backup.process_repo_builds(repository)
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
          backup.process_repo_builds(repository)
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
          backup.process_repo_builds(repository)
        end



        # saved_files_paths = []

        # allow(File).to receive(:open).and_wrap_original do |method, *args, &block|
        #   saved_files_paths.push(args.first)
        #   method.call(*args, &block)
        # end

        # backup.process_repo_builds(repository)

        # expect(saved_files_paths).to match_array([
        # ])
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
      it 'should save proper build JSON to file' do
        expect_any_instance_of(File).to receive(:write).once.with(JSON.pretty_generate(expected_requests_json))
        backup.process_repo_requests(repository)
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

def expect_method_calls_on(cl, method, call_with, options)
  match_mode = options[:mode] || :including
  allow_instances = options[:allow_instances] || false
  arguments_to_check = options[:arguments_to_check] || :all

  calls_args = []

  allowed = allow_instances ? allow_any_instance_of(cl) : allow(cl)

  allowed.to receive(method).and_wrap_original do |method, *args, &block|
    if arguments_to_check == :all
      calls_args.push(args)
    else
      calls_args.push(args.send(arguments_to_check)) # = args.first, args.second, args.third etc.
    end
    method.call(*args, &block)
  end

  yield

  case match_mode
  when :including
    call_with.each do |args|
      expect(calls_args).to include(args)
    end
  when :match
    expect(call_with).to match_array(calls_args)
  end
end
