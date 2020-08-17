class AddFutureToNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :is_future, :boolean, default: true
  end
end
