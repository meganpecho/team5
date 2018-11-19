class AddMajorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :major, foreign_key: true
  end
end
