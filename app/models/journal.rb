class Journal < ApplicationRecord
  has_many :notes
  belongs_to :category, required: false

  has_rich_text :content

  COLD_AFTER = 14.days
  COOL_AFTER = 7.days

  scope :cold, ->  { where("updated_at < ?", Date.today - COLD_AFTER) }
  scope :not_cold, ->  { where("updated_at > ?", Date.today - COLD_AFTER) }

  def is_cool?
    self.updated_at < (Date.today - COOL_AFTER)
  end

  def is_cold?
    self.updated_at < (Date.today - COLD_AFTER)
  end
end
