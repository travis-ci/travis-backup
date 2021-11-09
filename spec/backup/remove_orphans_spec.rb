$: << 'lib'
require 'uri'
require 'travis-backup'
require 'models/build'
require 'models/job'
require 'models/organization'
require 'models/user'
require 'support/factories'
require 'support/before_tests'
require 'pry'
require 'database_cleaner/active_record'

describe Backup::RemoveOrphans do
  before(:all) do
    BeforeTests.new.run
  end

  let(:files_location) { "dump/tests" }
  let!(:config) { Config.new(files_location: files_location, limit: 5) }
  let!(:db_helper) { DbHelper.new(config) }
  let!(:remove_orphans) { Backup::RemoveOrphans.new(config, DryRunReporter.new) }

  describe 'run' do
    before(:each) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
    end

    let!(:data) {
      db_helper.do_without_triggers do
        FactoryBot.create_list(:repository, 2)
        FactoryBot.create_list(:build, 2)
        FactoryBot.create_list(:job, 2)
        FactoryBot.create_list(:branch, 2, repository_id: 1)
        FactoryBot.create_list(:tag, 2)
        FactoryBot.create_list(:commit, 2)
        FactoryBot.create_list(:cron, 2)
        FactoryBot.create_list(:pull_request, 2)
        FactoryBot.create_list(:request, 2)
        FactoryBot.create_list(:stage, 2)
        FactoryBot.create_list(:repository_orphaned_on_current_build_id, 2)
        FactoryBot.create_list(:repository_with_current_build_id, 2)
        FactoryBot.create_list(:repository_orphaned_on_last_build_id, 2)
        FactoryBot.create_list(:repository_with_last_build_id, 2)
        FactoryBot.create_list(:build_orphaned_on_repository_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_repository_id, 2)
        FactoryBot.create_list(:build_orphaned_on_commit_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_commit_id, 2)
        FactoryBot.create_list(:build_orphaned_on_request_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_request_id, 2)
        FactoryBot.create_list(:build_orphaned_on_pull_request_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_pull_request_id, 2)
        FactoryBot.create_list(:build_orphaned_on_branch_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_branch_id, 2)
        FactoryBot.create_list(:build_orphaned_on_tag_id_with_mutually_related_repo, 2)
        FactoryBot.create_list(:build_with_tag_id, 2)
        FactoryBot.create_list(:job_orphaned_on_repository_id, 2)
        FactoryBot.create_list(:job_with_repository_id, 2)
        FactoryBot.create_list(:job_orphaned_on_commit_id, 2)
        FactoryBot.create_list(:job_with_commit_id, 2)
        FactoryBot.create_list(:job_orphaned_on_stage_id, 2)
        FactoryBot.create_list(:job_with_stage_id, 2)
        FactoryBot.create_list(:branch_orphaned_on_repository_id, 2)
        FactoryBot.create_list(:branch_orphaned_on_last_build_id, 2)
        FactoryBot.create_list(:branch_with_last_build_id, 2)
        FactoryBot.create_list(:tag_orphaned_on_repository_id, 2)
        FactoryBot.create_list(:tag_with_repository_id, 2)
        FactoryBot.create_list(:tag_orphaned_on_last_build_id, 2)
        FactoryBot.create_list(:tag_with_last_build_id, 2)
        FactoryBot.create_list(:commit_orphaned_on_repository_id, 2)
        FactoryBot.create_list(:commit_with_repository_id, 2)
        FactoryBot.create_list(:commit_orphaned_on_branch_id, 2)
        FactoryBot.create_list(:commit_with_branch_id, 2)
        FactoryBot.create_list(:commit_orphaned_on_tag_id, 2)
        FactoryBot.create_list(:commit_with_tag_id, 2)
        FactoryBot.create_list(:cron_orphaned_on_branch_id, 2)
        FactoryBot.create_list(:cron_with_branch_id, 2)
        FactoryBot.create_list(:pull_request_orphaned_on_repository_id, 2)
        FactoryBot.create_list(:pull_request_with_repository_id, 2)
        FactoryBot.create_list(:request_orphaned_on_commit_id, 2)
        FactoryBot.create_list(:request_with_commit_id, 2)
        FactoryBot.create_list(:request_orphaned_on_pull_request_id, 2)
        FactoryBot.create_list(:request_with_pull_request_id, 2)
        FactoryBot.create_list(:request_orphaned_on_branch_id, 2)
        FactoryBot.create_list(:request_with_branch_id, 2)
        FactoryBot.create_list(:request_orphaned_on_tag_id, 2)
        FactoryBot.create_list(:request_with_tag_id, 2)
        FactoryBot.create_list(:stage_orphaned_on_build_id, 2)
        FactoryBot.create_list(:stage_with_build_id, 2)
      end
    }
    it 'removes orphaned repositories (with these dependent on orphaned builds)' do
      expect { remove_orphans.run }.to change { Repository.all.size }.by -16
    end

    it 'removes orphaned builds' do
      expect { remove_orphans.run }.to change { Build.all.size }.by -12
    end

    it 'removes orphaned jobs' do
      expect { remove_orphans.run }.to change { Job.all.size }.by -6
    end

    it 'removes orphaned branches' do
      expect { remove_orphans.run }.to change { Branch.all.size }.by -4
    end

    it 'removes orphaned tags' do
      expect { remove_orphans.run }.to change { Tag.all.size }.by -4
    end

    it 'removes orphaned commits' do
      expect { remove_orphans.run }.to change { Commit.all.size }.by -6
    end

    it 'removes orphaned crons' do
      expect { remove_orphans.run }.to change { Cron.all.size }.by -2
    end

    it 'removes orphaned pull requests' do
      expect { remove_orphans.run }.to change { PullRequest.all.size }.by -2
    end

    it 'removes orphaned requests' do
      expect { remove_orphans.run }.to change { Request.all.size }.by -8
    end

    it 'removes orphaned stages' do
      expect { remove_orphans.run }.to change { Stage.all.size }.by -2
    end

    context 'when dry run mode is on' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, dry_run: true) }
      let!(:remove_orphans) { Backup::RemoveOrphans.new(config, DryRunReporter.new) }

      before do
        allow_any_instance_of(IO).to receive(:puts)
      end

      it 'prepares proper dry run report' do
        remove_orphans.run
        report = remove_orphans.dry_run_report
        expect(report[:repositories].size).to eql 16
        expect(report[:builds].size).to eql 12
        expect(report[:jobs].size).to eql 6
        expect(report[:branches].size).to eql 4
        expect(report[:tags].size).to eql 4
        expect(report[:commits].size).to eql 6
        expect(report[:crons].size).to eql 2
        expect(report[:pull_requests].size).to eql 2
        expect(report[:requests].size).to eql 8
        expect(report[:stages].size).to eql 2
      end
    end

    context 'when orphans table is defined' do
      let!(:config) { Config.new(files_location: files_location, limit: 5, orphans_table: 'jobs') }
      let!(:remove_orphans) { Backup::RemoveOrphans.new(config, DryRunReporter.new) }

      it 'removes orphans from that defined table' do
        expect { remove_orphans.run }.to change { Job.all.size }.by -6
      end

      it 'does not remove orphans from other tables' do
        expect { remove_orphans.run }.to change { Model.sum_of_subclasses_rows(except: 'jobs') }.by 0
      end
    end
  end
end
