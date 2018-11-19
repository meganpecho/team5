class Prerequisite < ApplicationRecord
  belongs_to :course
  
  def prerequisite
    return Course.where("id = ?", self.prerequisite_id)[0]
  end
end
