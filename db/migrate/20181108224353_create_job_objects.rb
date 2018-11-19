class CreateJobObjects < ActiveRecord::Migration[5.1]
  def change
    create_table :job_objects do |t|
      t.integer :listing_id
      t.string :title
      t.text :description
      t.string :apply_text
      t.string :apply_url
      t.date :post_date
      t.boolean :relocation_assistance
      t.boolean :telecommunication
      t.string :category
      t.text :keywords
      t.string :job_type
      t.string :company_name
      t.string :company_url
      t.string :company_logo
      t.string :company_tagline
      t.string :job_url

      t.timestamps
    end
  end
end
