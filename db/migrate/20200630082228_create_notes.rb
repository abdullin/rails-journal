class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :journal, null: false, foreign_key: true
      t.date :origin

      t.timestamps
    end
  end
end
