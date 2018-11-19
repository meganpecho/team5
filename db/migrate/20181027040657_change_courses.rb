class ChangeCourses < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :courses, :course_ids
  end
end
