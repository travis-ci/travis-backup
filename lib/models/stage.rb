# frozen_string_literal: true

require 'model'

class Stage < Model
  self.inheritance_column = :_type_disabled

  belongs_to :build
  has_many :jobs
  has_many :deleted_jobs
end
