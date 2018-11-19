class AddPerksToJobObject < ActiveRecord::Migration[5.1]
  def change
    add_column :job_objects, :perks, :string
  end
end
