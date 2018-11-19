class AddSearchLocationToJobSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :job_searches, :search_location, :string
  end
end
