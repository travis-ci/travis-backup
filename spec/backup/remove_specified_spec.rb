$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'support/before_tests'
require 'support/utils'
require 'pry'
require 'byebug'

describe Backup::RemoveSpecified do
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

    let!(:repository) {
      db_helper.do_without_triggers do
        FactoryBot.create(
          :repository_for_removing_heavy_data,
          created_at: datetime,
          updated_at: datetime
        )
      end
    }

    shared_context 'removing builds with dependencies' do
      it 'removes builds with all its dependencies' do
        expect {
          remove_specified.remove_repo_builds(repository)
        }.to change { Model.get_sum_of_rows_of_all_subclasses }.by(-16)
        .and change { Log.all.size }.by(-2)
        .and change { Job.all.size }.by(-6)
        .and change { Build.all.size }.by(-2)
        .and change { Request.all.size }.by(0)
        .and change { Repository.all.size }.by(0)
        .and change { Branch.all.size }.by(0)
        .and change { Tag.all.size }.by(0)
        .and change { Commit.all.size }.by(0)
        .and change { Cron.all.size }.by(0)
        .and change { PullRequest.all.size }.by(0)
        .and change { SslKey.all.size }.by(0)
        .and change { Stage.all.size }.by(-2)
        .and change { Star.all.size }.by(0)
        .and change { Permission.all.size }.by(0)
        .and change { Message.all.size }.by(0)
        .and change { Abuse.all.size }.by(0)
        .and change { Annotation.all.size }.by(-2)
        .and change { QueueableJob.all.size }.by(-2)
        .and change { Email.all.size }.by(0)
        .and change { Invoice.all.size }.by(0)
        .and change { Membership.all.size }.by(0)
        .and change { Organization.all.size }.by(0)
        .and change { OwnerGroup.all.size }.by(0)
        .and change { Broadcast.all.size }.by(0)
        .and change { Subscription.all.size }.by(0)
        .and change { Token.all.size }.by(0)
        .and change { TrialAllowance.all.size }.by(0)
        .and change { Trial.all.size }.by(0)
        .and change { UserBetaFeature.all.size }.by(0)
        .and change { User.all.size }.by(0)
      end
    end

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_repo_builds(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it_behaves_like 'removing builds with dependencies'

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
      it_behaves_like 'removing builds with dependencies'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_repo_builds(repository)
        }.not_to change { Model.get_sum_of_rows_of_all_subclasses }
      end
    end
  end

  describe 'remove_repo_requests' do
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

    shared_context 'removing requests with dependencies' do
      it 'removes requests with all its dependencies' do
        expect {
          remove_specified.remove_repo_requests(repository)
        }.to change { Model.get_sum_of_rows_of_all_subclasses }.by(-16)
        .and change { Log.all.size }.by(-2)
        .and change { Job.all.size }.by(-2)
        .and change { Build.all.size }.by(-2)
        .and change { Request.all.size }.by(-2)
        .and change { Repository.all.size }.by(0)
        .and change { Branch.all.size }.by(0)
        .and change { Tag.all.size }.by(0)
        .and change { Commit.all.size }.by(0)
        .and change { Cron.all.size }.by(0)
        .and change { PullRequest.all.size }.by(0)
        .and change { SslKey.all.size }.by(0)
        .and change { Stage.all.size }.by(0)
        .and change { Star.all.size }.by(0)
        .and change { Permission.all.size }.by(0)
        .and change { Message.all.size }.by(-2)
        .and change { Abuse.all.size }.by(-2)
        .and change { Annotation.all.size }.by(-2)
        .and change { QueueableJob.all.size }.by(-2)
        .and change { Email.all.size }.by(0)
        .and change { Invoice.all.size }.by(0)
        .and change { Membership.all.size }.by(0)
        .and change { Organization.all.size }.by(0)
        .and change { OwnerGroup.all.size }.by(0)
        .and change { Broadcast.all.size }.by(0)
        .and change { Subscription.all.size }.by(0)
        .and change { Token.all.size }.by(0)
        .and change { TrialAllowance.all.size }.by(0)
        .and change { Trial.all.size }.by(0)
        .and change { UserBetaFeature.all.size }.by(0)
        .and change { User.all.size }.by(0)
      end
    end

    shared_context 'not saving files' do
      it 'does not save files' do
        expect_any_instance_of(File).not_to receive(:write)
        remove_specified.remove_repo_requests(repository)
      end
    end

    context 'when if_backup config is set to true' do
      it_behaves_like 'removing requests with dependencies'

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
      it_behaves_like 'removing requests with dependencies'
    end

    context 'when dry_run config is set to true' do
      let!(:config) { Config.new(files_location: files_location, limit: 2, dry_run: true) }
      let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }

      it_behaves_like 'not saving files'

      it 'does not remove entries from db' do
        expect {
          remove_specified.remove_repo_requests(repository)
        }.not_to change { Model.get_sum_of_rows_of_all_subclasses }
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
        expect {
          remove_specified.remove_user_with_dependencies(user.id)
        }.to change { Model.get_sum_of_rows_of_all_subclasses }.by(-247)
        .and change { Log.all.size }.by(-30)
        .and change { Job.all.size }.by(-30)
        .and change { Build.all.size }.by(-18)
        .and change { Request.all.size }.by(-18)
        .and change { Repository.all.size }.by(-2)
        .and change { Branch.all.size }.by(-2)
        .and change { Tag.all.size }.by(-2)
        .and change { Commit.all.size }.by(-6)
        .and change { Cron.all.size }.by(-2)
        .and change { PullRequest.all.size }.by(-2)
        .and change { SslKey.all.size }.by(-2)
        .and change { Stage.all.size }.by(0)
        .and change { Star.all.size }.by(-4)
        .and change { Permission.all.size }.by(-4)
        .and change { Message.all.size }.by(-18)
        .and change { Abuse.all.size }.by(-20)
        .and change { Annotation.all.size }.by(-30)
        .and change { QueueableJob.all.size }.by(-30)
        .and change { Email.all.size }.by(-2)
        .and change { Invoice.all.size }.by(-4)
        .and change { Membership.all.size }.by(-2)
        .and change { Organization.all.size }.by(0)
        .and change { OwnerGroup.all.size }.by(-2)
        .and change { Broadcast.all.size }.by(-2)
        .and change { Subscription.all.size }.by(-2)
        .and change { Token.all.size }.by(-2)
        .and change { TrialAllowance.all.size }.by(-6)
        .and change { Trial.all.size }.by(-2)
        .and change { UserBetaFeature.all.size }.by(-2)
        .and change { User.all.size }.by(-1)
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
        }.not_to change { Model.get_sum_of_rows_of_all_subclasses }
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
        expect {
          remove_specified.remove_org_with_dependencies(organization.id)
        }.to change { Model.get_sum_of_rows_of_all_subclasses }.by(-237)
        .and change { Log.all.size }.by(-30)
        .and change { Job.all.size }.by(-30)
        .and change { Build.all.size }.by(-18)
        .and change { Request.all.size }.by(-18)
        .and change { Repository.all.size }.by(-2)
        .and change { Branch.all.size }.by(-2)
        .and change { Tag.all.size }.by(-2)
        .and change { Commit.all.size }.by(-6)
        .and change { Cron.all.size }.by(-2)
        .and change { PullRequest.all.size }.by(-2)
        .and change { SslKey.all.size }.by(-2)
        .and change { Stage.all.size }.by(0)
        .and change { Star.all.size }.by(-2)
        .and change { Permission.all.size }.by(-2)
        .and change { Message.all.size }.by(-18)
        .and change { Abuse.all.size }.by(-20)
        .and change { Annotation.all.size }.by(-30)
        .and change { QueueableJob.all.size }.by(-30)
        .and change { Email.all.size }.by(0)
        .and change { Invoice.all.size }.by(-4)
        .and change { Membership.all.size }.by(-2)
        .and change { Organization.all.size }.by(-1)
        .and change { OwnerGroup.all.size }.by(-2)
        .and change { Broadcast.all.size }.by(-2)
        .and change { Subscription.all.size }.by(-2)
        .and change { Token.all.size }.by(0)
        .and change { TrialAllowance.all.size }.by(-6)
        .and change { Trial.all.size }.by(-2)
        .and change { UserBetaFeature.all.size }.by(0)
        .and change { User.all.size }.by(0)
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
        }.not_to change { Model.get_sum_of_rows_of_all_subclasses }
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
        expect {
          remove_specified.remove_repo_with_dependencies(repository.id)
        }.to change { Model.get_sum_of_rows_of_all_subclasses }.by(-173)
        .and change { Log.all.size }.by(-24)
        .and change { Job.all.size }.by(-24)
        .and change { Build.all.size }.by(-14)
        .and change { Request.all.size }.by(-14)
        .and change { Repository.all.size }.by(-1)
        .and change { Branch.all.size }.by(-2)
        .and change { Tag.all.size }.by(-2)
        .and change { Commit.all.size }.by(-6)
        .and change { Cron.all.size }.by(-2)
        .and change { PullRequest.all.size }.by(-2)
        .and change { SslKey.all.size }.by(-2)
        .and change { Stage.all.size }.by(0)
        .and change { Star.all.size }.by(-2)
        .and change { Permission.all.size }.by(-2)
        .and change { Message.all.size }.by(-14)
        .and change { Abuse.all.size }.by(-14)
        .and change { Annotation.all.size }.by(-24)
        .and change { QueueableJob.all.size }.by(-24)
        .and change { Email.all.size }.by(0)
        .and change { Invoice.all.size }.by(0)
        .and change { Membership.all.size }.by(0)
        .and change { Organization.all.size }.by(0)
        .and change { OwnerGroup.all.size }.by(0)
        .and change { Broadcast.all.size }.by(0)
        .and change { Subscription.all.size }.by(0)
        .and change { Token.all.size }.by(0)
        .and change { TrialAllowance.all.size }.by(0)
        .and change { Trial.all.size }.by(0)
        .and change { UserBetaFeature.all.size }.by(0)
        .and change { User.all.size }.by(0)
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
        }.not_to change { Model.get_sum_of_rows_of_all_subclasses }
      end
    end
  end
end
