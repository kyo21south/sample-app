class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length:{maximum: 140}
  validate :picture_size
  has_many :favorite_relationships, class_name: "Favorite", foreign_key: "micropost_id", dependent: :destroy
  has_many :favorer, through: :favorite_relationships, source: :user
  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
