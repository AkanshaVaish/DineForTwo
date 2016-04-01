class Restaurant < ActiveRecord::Base
	#has many and belongs to many association with people
	has_and_belongs_to_many :people
end
