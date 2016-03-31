class AddUniqueIndexForPersonAndRestaurantId < ActiveRecord::Migration
  def change
  	add_index :reservations, [:person_id, :restaurant_id], unique: true
  end
end
