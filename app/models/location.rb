class Location < ActiveRecord::Base
  has_many :restaurants
  has_many :people
end
