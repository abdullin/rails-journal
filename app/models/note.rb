class Note < ApplicationRecord
  belongs_to :journal
  has_rich_text :content

  def timeless?
    created_at.year == 9999
    
  end
end
