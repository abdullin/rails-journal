class Journal < ApplicationRecord
  has_many :notes

  has_rich_text :content
end
