class Journal < ApplicationRecord
  has_many :notes
  belongs_to :category, required: false

  has_rich_text :content

  def is_cool?
    self.updated_at < (Date.today - 7.days)
  end

  def is_cold?
    self.updated_at < (Date.today - 14.days)
  end
end
