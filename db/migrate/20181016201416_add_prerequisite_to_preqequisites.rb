class AddPrerequisiteToPreqequisites < ActiveRecord::Migration[5.1]
  def change
    add_column :prerequisites, :prerequisite_id, :integer
  end
end
