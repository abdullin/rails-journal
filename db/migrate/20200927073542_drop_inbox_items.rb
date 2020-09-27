class DropInboxItems < ActiveRecord::Migration[6.0]
  def change
    drop_table :inbox_items
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
