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
        [
          100,
          {
            job: [
              {
                log: [100, 101],
                annotation: [100, 101],
                queueable_job: [100, 101],
                id: 216
              },
              217
            ],
            stage: [
              {
                job: [212, 213],
                id: 100
              },
              {
                job: [214, 215],
                id: 101
              }
            ],
            id: 211
          }
        ]
      }

      it 'loads data properly' do
        load_from_files.run
        expect(Build.all.map(&:ids_of_all_dependencies_nested)).to eql(expected_structure)
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
