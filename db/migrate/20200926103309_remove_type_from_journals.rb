class RemoveTypeFromJournals < ActiveRecord::Migration[6.0]
  def change
    remove_column :journals, :type, :string
  end
end
