class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :course_id
      t.string :subject
      t.text :subject_desc
      t.integer :course_num
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
