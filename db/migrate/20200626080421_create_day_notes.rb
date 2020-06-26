class CreateDayNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :day_notes do |t|
      t.date :day, :null => false

      t.timestamps
    end

    add_index :day_notes, :day, unique: true
  end
end
