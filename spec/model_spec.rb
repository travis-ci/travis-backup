$: << 'lib'
require './model'
require 'travis-backup'
require 'support/factories'
require 'support/before_tests'
require 'byebug'

describe Model do
  before(:each) do
    BeforeTests.new.run
  end

  describe 'ids_of_all_dependencies' do
    let!(:config) { Config.new(limit: 5) }
    let!(:db_helper) { DbHelper.new(config) }
    let(:datetime) { (Config.new.threshold + 1).months.ago.to_time.utc }

    let!(:commit) {
      FactoryBot.create(
        :commit_with_all_dependencies,
        created_at: datetime,
        updated_at: datetime
      )
    }
    context 'when no filters are given' do
      it 'returns all dependencies ids in hash' do
        expect(commit.ids_of_all_dependencies).to eql({
          filtered_out: {},
          main: {
            abuse: [1, 2],
            annotation: [1, 2, 3, 4],
            branch: [73, 74],
            build: [1, 3, 6, 8],
            job: [2, 4, 5, 9, 10, 7],
            log: [1, 2, 3, 4],
            message: [1, 2],
            queueable_job: [1, 2, 3, 4],
            repository: [2, 1, 4, 3],
            request: [1, 2],
            stage: [20, 21],
            tag: [1, 2]
          }
        })
      end
    end

    context 'when the only filter is given' do
      it 'returns all dependencies ids in hash' do
        filter = {
          only: {
            request: [ :jobs, :builds ]
          }
        }
        expect(commit.ids_of_all_dependencies(filter)).to eql({
          filtered_out: {
            abuse: [1, 2],
            annotation: [1, 2],
            branch: [73],
            build: [1, 3],
            job: [2, 4, 5],
            log: [1, 2],
            message: [1, 2],
            queueable_job: [1, 2],
            repository: [2, 1],
            request: [1, 2],
            stage: [20],
            tag: [1]
          },
          main: {
            annotation: [3, 4],
            branch: [74],
            build: [6, 8],
            job: [9, 10, 7],
            log: [3, 4],
            queueable_job: [3, 4],
            repository: [4, 3],
            stage: [21],
            tag: [2]
          }
        })
      end
    end

    context 'when the except filter is given' do
      it 'returns all dependencies ids in hash' do
        filter = {
          except: {
            request: [ :jobs, :builds ]
          }
        }
        expect(commit.ids_of_all_dependencies(filter)).to eql({
          main: {
            abuse: [1, 2],
            annotation: [1, 2],
            branch: [73],
            build: [1, 3],
            job: [2, 4, 5],
            log: [1, 2],
            message: [1, 2],
            queueable_job: [1, 2],
            repository: [2, 1],
            request: [1, 2],
            stage: [20],
            tag: [1]
          },
          filtered_out: {
            annotation: [3, 4],
            branch: [74],
            build: [6, 8],
            job: [9, 10, 7],
            log: [3, 4],
            queueable_job: [3, 4],
            repository: [4, 3],
            stage: [21],
            tag: [2]
          }
        })
      end
    end
  end
end
