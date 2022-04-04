# frozen_string_literal: true

require 'model'

class DeletedCommit < Model
  belongs_to :related_branch, foreign_key: :branch_id, class_name: 'Branch'
  belongs_to :repository
  belongs_to :tag
  self.primary_key = 'id'

end
