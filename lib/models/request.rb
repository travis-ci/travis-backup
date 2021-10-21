# frozen_string_literal: true

require 'model'
require 'models/repository'

class Request < Model
  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :repository
  belongs_to :branch
  belongs_to :pull_request
  belongs_to :tag
  belongs_to :commit
  has_many :abuses
  has_many :messages, as: :subject
  has_many :jobs, as: :source
  has_many :builds

  self.table_name = 'requests'
end
