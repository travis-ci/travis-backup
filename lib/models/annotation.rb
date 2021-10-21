# frozen_string_literal: true

require 'model'

class Annotation < Model
  belongs_to :job
  self.table_name = 'annotations'
end
