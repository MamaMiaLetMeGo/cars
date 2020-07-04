class Car < ApplicationRecord
  has_and_belongs_to_many :makes
  has_and_belongs_to_many :states
  has_and_belongs_to_many :transmissions
  has_one_attached :thumbnail
  has_many_attached :images
  has_rich_text :description
  validates :title, presence: true
  validates :description, presence: true
  validate :image_type
  acts_as_votable

  def resized_thumbnail
    thumbnail.variant(resize: "240x135!")
  end

  def manyimage input
    return self.images[input].variant(resize: '350x250!').processed
  end
  
  private
  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%('image/jpeg image/jpg image/png'))
        errors.add(:images, 'needs to be a JPEG, JPG or PNG')
      end
    end
  end
end
