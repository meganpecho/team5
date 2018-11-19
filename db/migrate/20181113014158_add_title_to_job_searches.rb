class AddTitleToJobSearches < ActiveRecord::Migration[5.1]
  def change
    add_column :job_searches, :title, :string
  end
end
