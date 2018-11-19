class DropSetupsTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :setups
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
