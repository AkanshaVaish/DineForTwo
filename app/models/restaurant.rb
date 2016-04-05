class Restaurant < ActiveRecord::Base

	#has many and belongs to many association with people
	has_and_belongs_to_many :people

  belongs_to :person

  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorited_restaurants, source: :person

  belongs_to :location

  validates :name, presence: true
<<<<<<< HEAD

=======
  validates :person_id, uniqueness: true

  mount_uploader :avatar, AvatarUploader
>>>>>>> 60b156124fddfd4bf6bf27d16a0d99c06c596a63
end
