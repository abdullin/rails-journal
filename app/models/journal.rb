class Journal < ApplicationRecord
  has_many :notes
  belongs_to :category, required: false

  has_rich_text :content
end
