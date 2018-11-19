class Setup < ApplicationRecord
  belongs_to :user
  
  def isFinished?
    return self.finished
  end
end
