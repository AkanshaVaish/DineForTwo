class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :person_id
      t.string :name

      t.timestamps null: false
    end
  end
end
