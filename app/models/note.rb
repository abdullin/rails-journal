class Note < ApplicationRecord
  belongs_to :journal
  has_rich_text :content

  scope :visible, -> { where(archived_at:nil).where("created_at < ?", Date.today.beginning_of_day) }
  scope :future, ->  { where(archived_at:nil).where("created_at > ?", DateTime.now) }




  def timeless?
    created_at.year == 9999
    
  end
end
