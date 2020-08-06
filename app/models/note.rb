class Note < ApplicationRecord

  belongs_to :journal
  has_rich_text :content

  scope :visible, -> { where(archived_at:nil).where("notes.created_at < ?", DateTime.now) }
  scope :future, ->  { where(archived_at:nil).where("notes.created_at > ?", DateTime.now) }

  scope :with_category, lambda { | id | joins(:journal).where("journals.category_id = ?", id) }
  scope :within_week, lambda { | date | where(:created_at => date.beginning_of_week..date.end_of_week) }
end
