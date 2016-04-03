class Restaurant < ActiveRecord::Base
<<<<<<< HEAD
	#has many and belongs to many association with people
	has_and_belongs_to_many :people
=======
  belongs_to :person

  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorited_restaurants, source: :persons

  validates :name, presence: true
>>>>>>> b5b76b37234ce790c3883c6362a305357c04db04
end
