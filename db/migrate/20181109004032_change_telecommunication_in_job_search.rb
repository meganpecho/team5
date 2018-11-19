class ChangeTelecommunicationInJobSearch < ActiveRecord::Migration[5.1]
  def change
    rename_column :job_objects, :telecommunication, :telecommuting
  end
end
