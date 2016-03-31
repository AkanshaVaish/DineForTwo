class Reservation < ActiveRecord::Base
	belongs_to :people
	belongs_to :restaurants
	validates :person_id, presence: true
	validates :restaurant_id, presence: true
end
