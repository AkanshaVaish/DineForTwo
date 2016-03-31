class Restaurant < ActiveRecord::Base
	#Each restaurant will be associated with many reservations
	has_many :reservations
	#Each restaurant will be associated with many people through the reservations associated with the people
	has_many :people, through: :reservations
end
