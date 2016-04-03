class CreateFavoriteRestaurants < ActiveRecord::Migration
  def change
    create_table :favorite_restaurants do |t|
      t.integer :restaurant_id
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
