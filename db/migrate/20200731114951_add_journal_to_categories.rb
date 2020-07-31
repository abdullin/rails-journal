class AddJournalToCategories < ActiveRecord::Migration[6.0]
  def change
    
    add_reference :journals, :category
    add_foreign_key :journals, :categories
  end
end
