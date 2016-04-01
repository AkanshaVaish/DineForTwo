class CreatePeopleAndRestaurants < ActiveRecord::Migration
  def change
  	create_table :restaurants do |t|
  		t.string :name
  		t.string :location
  		t.timestamps null: false
  	end

    create_table :people_restaurants, id: false do |t|
    	t.belongs_to :person, index: true
    	t.belongs_to :restaurant, index: true
	end
  end
end
