class CreateCourseSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :course_skills do |t|
      t.references :course, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
