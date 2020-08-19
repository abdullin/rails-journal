class Journal < ApplicationRecord
  has_many :notes
  belongs_to :category, required: false

  has_rich_text :content

  def is_cold?
    self.updated_at < (Date.today - 7.days)
  end
end
