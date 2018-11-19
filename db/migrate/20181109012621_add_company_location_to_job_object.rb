class AddCompanyLocationToJobObject < ActiveRecord::Migration[5.1]
  def change
    add_column :job_objects, :company_location, :string
  end
end
