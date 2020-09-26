class AddKind2ToJournals < ActiveRecord::Migration[6.0]
  def change
    add_column :journals, :kind, :string
  end
end
