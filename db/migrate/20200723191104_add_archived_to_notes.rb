class AddArchivedToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :archived_at, :timestamp
  end
end
