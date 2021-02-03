$: << 'lib'
require 'backup'
require 'rspec/active_model/mocks'

describe Backup do
  let!(:repository) { stub_model(Repository) }

  it 'should prepare proper JSON export' do
    expect(Backup.export).not_to be nil
  end
end
