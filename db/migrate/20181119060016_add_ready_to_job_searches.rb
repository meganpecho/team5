class AddReadyToJobSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :job_searches, :ready, :boolean
  end
end
