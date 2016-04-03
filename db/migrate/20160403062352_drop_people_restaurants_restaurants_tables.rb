class DropPeopleRestaurantsRestaurantsTables < ActiveRecord::Migration
  def change
    drop_table :people_restaurants
    drop_table :restaurants
  end
end
