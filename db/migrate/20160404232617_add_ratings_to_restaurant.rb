class AddRatingsToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :ratings, :integer
  end
end
