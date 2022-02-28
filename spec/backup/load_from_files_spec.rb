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
require 'support/expected_id_trees/load_from_files'
require 'pry'
require 'byebug'

describe Backup::LoadFromFiles do
  before(:each) do
    BeforeTests.new.run
  end

  let(:files_location) { "spec/support/expected_files/remove_repo_builds" }
  let!(:config) { Config.new(files_location: files_location, load_from_files: true, id_gap: 100) }
  let!(:db_helper) { DbHelper.new(config) }
  let!(:load_from_files) { Backup::LoadFromFiles.new(config, DryRunReporter.new) }

  describe 'run' do
    context 'when it has remove_repo_builds resulting files to load' do
      let!(:expected_structure) {
        ExpectedIdTrees.load_from_files
      }

      let!(:related_nullified_entries) {
        FactoryBot.create(:repository, id: 1)
        FactoryBot.create(:repository, id: 18)
        FactoryBot.create(:repository, id: 19)
        FactoryBot.create(:repository, id: 20)
        FactoryBot.create(:repository, id: 21)
        FactoryBot.create(:tag, id: 1)
        FactoryBot.create(:tag, id: 6)
        FactoryBot.create(:branch, id: 77, repository_id: 1)
        FactoryBot.create(:branch, id: 82, repository_id: 1)
      }

      it 'loads entries properly' do
        load_from_files.run
        expect(Build.all.map { |b| b.ids_of_all_dependencies_nested(2) }).to eql(expected_structure)
      end

      it 'loads relationships properly' do
        load_from_files.run
        expect(Repository.find(1).last_build_id).to eql(274)
        expect(Repository.find(20).current_build_id).to eql(100)
        expect(Repository.find(21).current_build_id).to eql(100)
        expect(Repository.find(18).last_build_id).to eql(100)
        expect(Repository.find(19).last_build_id).to eql(100)
        expect(Tag.find(1).last_build_id).to eql(100)
        expect(Tag.find(6).last_build_id).to eql(100)
        expect(Branch.find(77).last_build_id).to eql(100)
        expect(Branch.find(82).last_build_id).to eql(100)
      end

      it 'sets id sequences properly' do
        load_from_files.run
        expected_ids = [
          Job.last.id + 1,
          Job.last.id + 2,
          Log.last.id + 1,
          Stage.last.id + 1,
          Annotation.last.id + 1,
          QueueableJob.last.id + 1,
        ]

        expect([
          Build.create({}).id,
          Job.create({}).id,
          Log.create({}).id,
          Stage.create({}).id,
          Annotation.create({job_id: 1, description: 'x', annotation_provider_id: 1}).id,
          QueueableJob.create({}).id
        ]).to eql(expected_ids)
      end
    end

    context 'when old data is present in db' do
      context 'when it cooperates with removing method in dumping and reloading' do
        context 'when it cooperates with remove_user_with_dependencies' do
          let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }
          let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }
          let!(:other_data) {
            FactoryBot.rewind_sequences
    
            db_helper.do_without_triggers do
              FactoryBot.create_list(
                :user_with_all_dependencies, 2,
                created_at: datetime,
                updated_at: datetime            
              )
            end
          }
          let!(:user) {
            db_helper.do_without_triggers do
              FactoryBot.create(
                :user_with_all_dependencies,
                created_at: datetime,
                updated_at: datetime
              )
            end
          }
    
          it 'reloads data properly' do
            time_for_folder = Time.now.to_s.parameterize.underscore
            config.files_location = "dump/tests/load_files/#{time_for_folder}_1"
            remove_specified.remove_user_with_dependencies(user.id)
            load_from_files.run
            loaded_user = User.last
            expected_data = loaded_user.ids_of_all_dependencies_nested
            config.files_location = "dump/tests/load_files/#{time_for_folder}_2"
            remove_specified.remove_user_with_dependencies(loaded_user.id)
            load_from_files = Backup::LoadFromFiles.new(config, DryRunReporter.new)
            load_from_files.run
    
            expect(User.last.ids_of_all_dependencies_nested).to eql(expected_data)
          end
        end

        context 'when it cooperates with remove_heavy_data_for_repo' do
          let!(:remove_specified) { Backup::RemoveSpecified.new(config, DryRunReporter.new) }
          let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }
          let!(:other_data) {
            FactoryBot.rewind_sequences
    
            db_helper.do_without_triggers do
              FactoryBot.create_list(
                :user_with_all_dependencies, 2,
                created_at: datetime,
                updated_at: datetime            
              )
            end
          }
          let!(:repository) {
            db_helper.do_without_triggers do
              FactoryBot.create(
                :repository_for_removing_heavy_data,
                created_at: datetime,
                updated_at: datetime
              )
            end
          }
    
          it 'reloads data properly' do
            time_for_folder = Time.now.to_s.parameterize.underscore
            config.files_location = "dump/tests/load_files/#{time_for_folder}_1"
            remove_specified.remove_heavy_data_for_repo(repository)
            load_from_files.run
            expected_data = repository.ids_of_all_dependencies_nested(6)
            config.files_location = "dump/tests/load_files/#{time_for_folder}_2"
            remove_specified.remove_heavy_data_for_repo(repository)
            load_from_files = Backup::LoadFromFiles.new(config, DryRunReporter.new)
            load_from_files.run
    
            expect(repository.ids_of_all_dependencies_nested(6)).to eql(expected_data)
          end
        end
      end
  
      context 'when the problem with associated data in db occurs' do
        before do
          config.files_location = "spec/support/expected_files/associated_db_data_problem"
        end

        let!(:repository) {
          db_helper.do_without_triggers do
            FactoryBot.create(
              :repository
            )
          end
        }

        it 'loads data with proper ids' do
          load_from_files.run
          expect(Build.all.map(&:repository_id)).to eql([1,1])
        end
      end
    end
  end
end
