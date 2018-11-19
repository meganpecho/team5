class AddSetupToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :setup, :boolean
  end
end
