class Car < ApplicationRecord
  has_and_belongs_to_many :makes
  has_and_belongs_to_many :states
  has_and_belongs_to_many :transmissions
  has_one_attached :thumbnail

  def resized_thumbnail
    thumbnail.variant(resize: "240x135!")
  end
end
