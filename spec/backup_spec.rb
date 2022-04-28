$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models'
require 'support/factories'
require 'support/before_tests'
require 'support/utils'
require 'pry'
require 'byebug'

describe Backup do
  before(:each) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:backup) { Backup.new(files_location: files_location, limit: 5) }

  describe 'run' do
    let!(:unassigned_repositories) {
      FactoryBot.create_list(:repository, 3)
    }
    let!(:user1) {
      FactoryBot.create(:user)
    }
    let!(:user2) {
      FactoryBot.create(:user)
    }
    let!(:organization1) {
      FactoryBot.create(:organization)
    }
    let!(:organization2) {
      FactoryBot.create(:organization)
    }

    context 'when threshold for heavy data is given' do
      context 'when no id arguments are given' do
        it 'removes heavy data from every repository' do
          Repository.all.each do |repository|
            expect_any_instance_of(Backup::RemoveSpecified).to receive(:remove_heavy_data_for_repo).once.with(repository)
          end
          backup.run
        end
      end

      context 'when user_id is given' do
        it 'removes heavy data from the repositories of the given user only' do
          user_repos = Repository.where('owner_id = ? and owner_type = ?', user1.id, 'User')

          expect_method_calls_on(
            Backup::RemoveSpecified,
            :remove_heavy_data_for_repo,
            user_repos,
            allow_instances: true,
            arguments_to_check: :first
          ) do
            backup.run(user_id: user1.id)
          end
        end
      end

      context 'when org_id is given' do
        it 'removes heavy data from the repositories of the given organization only' do
          org_repos = Repository.where('owner_id = ? and owner_type = ?', organization1.id, 'Organization')

          expect_method_calls_on(
            Backup::RemoveSpecified,
            :remove_heavy_data_for_repo,
            org_repos,
            allow_instances: true,
            arguments_to_check: :first
          ) do
            backup.run(org_id: organization1.id)
          end
        end
      end

      context 'when repo_id is given' do
        it 'removes heavy data from the repository with the given id only' do
          repo = Repository.first
          expect_any_instance_of(Backup::RemoveSpecified).to receive(:remove_heavy_data_for_repo).once.with(repo)
          backup.run(repo_id: repo.id)
        end
      end
    end

    context 'when threshold for heavy data is not given' do
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

    context 'when dry run mode is on' do
      let!(:backup) { Backup.new(files_location: files_location, limit: 10, dry_run: true, threshold: 0) }

      before do
        allow_any_instance_of(IO).to receive(:puts)
      end

      it 'prepares proper dry run report' do
        backup.run
        expect(backup.dry_run_report[:builds].size).to eql 24
        expect(backup.dry_run_report[:jobs].size).to eql 48
        expect(backup.dry_run_report[:requests].size).to eql 6
      end

      it 'prints dry run report' do
        expect_any_instance_of(DryRunReporter).to receive(:print_report).once
        backup.run
      end
    end
  end
end
