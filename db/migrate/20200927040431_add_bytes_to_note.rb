class AddBytesToNote < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :bytes, :integer
  end
end
