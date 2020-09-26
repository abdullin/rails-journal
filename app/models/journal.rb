class Journal < ApplicationRecord

  has_many :notes
  belongs_to :category, required: false

  has_rich_text :content


  include ActionText::Attachable

  def kind
    self[:kind] || "journal"
  end

  def plain?
    kind == "journal"
  end

  COLD_AFTER = 14.days
  COOL_AFTER = 7.days

  scope :plain, -> { where(:type => nil) }
  scope :people, -> { where(:kind => "person") }

  scope :cold, ->  { where("updated_at < ?", Date.today - COLD_AFTER) }
  scope :not_cold, ->  { where("updated_at > ?", Date.today - COLD_AFTER) }

  def is_cool?
    self.updated_at < (Date.today - COOL_AFTER)
  end

  def is_cold?
    self.updated_at < (Date.today - COLD_AFTER)
  end

  def shelve
    self.touch(time: Date.today - (COLD_AFTER + 1.day))
  end
end
