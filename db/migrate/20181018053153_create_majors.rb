class CreateMajors < ActiveRecord::Migration[5.1]
  def change
    create_table :majors do |t|
      t.string :title
      t.string :subject
      t.string :concentration

      t.timestamps
    end
  end
end
