class CreateJobSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :job_searches do |t|
      t.integer :search_type
      t.string :search_keywords
      t.string :search_results

      t.timestamps
    end
  end
end
