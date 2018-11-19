class CreateSetups < ActiveRecord::Migration[5.1]
  def change
    create_table :setups do |t|
      t.references :user, foreign_key: true
      t.boolean :finished

      t.timestamps
    end
  end
end
