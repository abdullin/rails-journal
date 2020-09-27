class AddStatisticsToNote < ActiveRecord::Migration[6.0]
  def change
    add_column :notes, :char_count, :integer
    add_column :notes, :word_count, :integer
  end
end
