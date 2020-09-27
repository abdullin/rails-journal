class CreateInboxItems < ActiveRecord::Migration[6.0]
  def change
    create_table :inbox_items do |t|

      t.timestamps
    end
  end
end
