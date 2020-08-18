class AddFuture2ToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :future, :boolean, default: false
  end
end
