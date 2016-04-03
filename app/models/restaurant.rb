class Restaurant < ActiveRecord::Base
  belongs_to :person

  has_many :favorite_restaurants
  has_many :favorited_by, through: :favorited_restaurants, source: :person

  validates :name, presence: true
end