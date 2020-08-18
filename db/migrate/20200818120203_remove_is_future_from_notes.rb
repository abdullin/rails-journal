class RemoveIsFutureFromNotes < ActiveRecord::Migration[6.0]
  def change
    remove_column :notes, :is_future
  end
end
