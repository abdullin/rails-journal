class Note < ApplicationRecord

  belongs_to :journal
  has_rich_text :content

  scope :not_archived, ->{ where(archived_at:nil) }
  scope :visible, -> { where(archived_at:nil).where("notes.created_at < ?", DateTime.now) }
  scope :future, ->  { where(archived_at:nil).where("notes.created_at > ?", DateTime.now) }

  scope :with_category, lambda { | id | joins(:journal).where("journals.category_id = ?", id) }
  scope :within_week, lambda { | date | where(:created_at => date.beginning_of_week..date.end_of_week) }
  scope :within_day, lambda { | date | where(:created_at => date.beginning_of_day..date.end_of_day) }

  scope :chronologically, -> { order(created_at: :asc) }
  scope :latest_first, -> { order(created_at: :desc) }

  before_save :set_future_flag, :compute_stats

  def headers
    content.body.fragment.find_all(:h1).map(&:text)
  end

  private
  def set_future_flag
    self.future = created_at.present? && created_at.future? 
  end


  def compute_stats
    self.bytes = total_size 

    text = content.to_plain_text
    self.word_count = text.split.size
    self.char_count = text.size
  end

  def total_size
    content.body.attachments.reduce(0) { | n, a |
      size = a.respond_to?(:byte_size) ? a.byte_size : 0
      n + size
    }
  end



end
