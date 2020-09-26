class AddKindToJournals < ActiveRecord::Migration[6.0]
  def change
    add_column :journals, :type, :string
  end
end
