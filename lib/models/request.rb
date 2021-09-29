# frozen_string_literal: true

require 'model'
require 'models/repository'

class Request < Model
  belongs_to :owner, polymorphic: true
  belongs_to :sender, polymorphic: true
  belongs_to :repository
  has_many :abuses
  has_many :messages, as: :subject
  has_many :jobs, as: :source
  has_many :builds

  self.table_name = 'requests'
end
