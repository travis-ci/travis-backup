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

    context 'when no id arguments are given' do
      it 'processes every repository' do
        Repository.all.each do |repository|
          expect_any_instance_of(Backup::RemoveSpecified).to receive(:remove_repo_builds).once.with(repository)
        end
        backup.run
      end
    end

    context 'when user_id is given' do
      it 'processes only the repositories of the given user' do
        user_repos = Repository.where('owner_id = ? and owner_type = ?', user1.id, 'User')

        expect_method_calls_on(
          Backup::RemoveSpecified,
          :remove_repo_builds,
          user_repos,
          allow_instances: true,
          arguments_to_check: :first
        ) do
          backup.run(user_id: user1.id)
        end
      end
    end

    context 'when org_id is given' do
      it 'processes only the repositories of the given organization' do
        org_repos = Repository.where('owner_id = ? and owner_type = ?', organization1.id, 'Organization')

        expect_method_calls_on(
          Backup::RemoveSpecified,
          :remove_repo_builds,
          org_repos,
          allow_instances: true,
          arguments_to_check: :first
        ) do
          backup.run(org_id: organization1.id)
        end
      end
    end

    context 'when repo_id is given' do
      it 'processes only the repository with the given id' do
        repo = Repository.first
        expect_any_instance_of(Backup::RemoveSpecified).to receive(:remove_repo_builds).once.with(repo)
        backup.run(repo_id: repo.id)
      end
    end

    context 'when threshold is not given' do
      context 'when user_id is given' do
        let!(:backup) { Backup.new(
          files_location: files_location,
          limit: 5,
          threshold: false,
          user_id: user1.id
        ) }
        it 'removes the user with all dependencies' do  
          expect_any_instance_of(Backup::RemoveSpecified)
            .to receive(:remove_user_with_dependencies).once.with(user1.id)
          backup.run(user_id: user1.id)
        end
      end
  
      context 'when org_id is given' do
        let!(:backup) { Backup.new(
          files_location: files_location,
          limit: 5,
          threshold: false,
          org_id: user1.id
        ) }
        it 'removes the organisation with all dependencies' do
          expect_any_instance_of(Backup::RemoveSpecified)
            .to receive(:remove_org_with_dependencies).once.with(organization1.id)
          backup.run(org_id: organization1.id)
        end
      end
  
      context 'when repo_id is given' do
        let!(:backup) { Backup.new(
          files_location: files_location,
          limit: 5,
          threshold: false,
          repo_id: user1.id
        ) }
        it 'removes the repo with all dependencies' do
          repo = Repository.first
          expect_any_instance_of(Backup::RemoveSpecified)
            .to receive(:remove_repo_with_dependencies).once.with(repo.id)
          backup.run(repo_id: repo.id)
        end
      end
    end

    context 'when move logs mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 5, move_logs: true) }

      it 'does not process repositories' do
        expect(backup).not_to receive(:remove_heavy_data_for_repo)
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
        expect(backup).not_to receive(:remove_heavy_data_for_repo)
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
end
