class Note < ApplicationRecord
  belongs_to :journal
  has_rich_text :content

  scope :visible, -> { where(archived_at:nil).where("created_at < ?", DateTime.now) }
  scope :future, ->  { where(archived_at:nil).where("created_at > ?", DateTime.now) }
end
