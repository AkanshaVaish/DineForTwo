class Restaurant < ActiveRecord::Base

	

  belongs_to :person

  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorited_restaurants, source: :person

  belongs_to :location

  validates :name, presence: true
  validates :description, presence: true

  mount_uploader :avatar, AvatarUploader
end
