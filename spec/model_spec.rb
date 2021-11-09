$: << 'lib'
require 'model'
require 'travis-backup'
require 'support/factories'
require 'support/before_tests'
require 'byebug'

describe Model do
  before(:each) do
    BeforeTests.new.run
  end

  describe 'ids_of_all_dependencies_with_filtered' do
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
    context 'when the filter is not given' do
      it 'returns all dependencies ids in hash' do
        expect(commit.ids_of_all_dependencies_with_filtered).to eql({
          filtered_out: {},
          main: {
            abuse: [1, 2],
            annotation: [1, 2, 3, 4],
            branch: [73, 74],
            build: [1, 3, 6, 8],
            job: [2, 4, 5, 7, 9, 10],
            log: [1, 2, 3, 4],
            message: [1, 2],
            queueable_job: [1, 2, 3, 4],
            repository: [1, 2, 3, 4],
            request: [1, 2],
            stage: [20, 21],
            tag: [1, 2]
          }
        })
      end
    end

    context 'when the filter is given' do
      let!(:to_filter) {
        { request: [ :jobs, :builds ] }
      }
      it 'returns all dependencies ids in hash' do
        expect(commit.ids_of_all_dependencies_with_filtered(to_filter)).to eql({
          main: {
            annotation: [1, 2],
            branch: [73],
            build: [1, 3],
            job: [2, 4, 5],
            log: [1, 2],
            queueable_job: [1, 2],
            repository: [1, 2],
            request: [2],
            stage: [20],
            tag: [1]
          },
          filtered_out: {
            request: [1]
          }
        })
      end

      context 'when filtered_children_only filtering strategy is set' do
        it 'returns all dependencies ids in hash' do
          expect(commit.ids_of_all_dependencies_with_filtered(to_filter, :filtered_children_only)).to eql({
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
              build: [6, 8],
              job: [9, 10]
            }
          })
        end
      end
    end
  end
end
