class Person < ApplicationRecord
  include ActionText::Attachable

  has_rich_text :content
end
