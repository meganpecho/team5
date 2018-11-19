class AddUserToJobSearch < ActiveRecord::Migration[5.1]
  def change
    add_reference :job_searches, :user, foreign_key: true
  end
end
