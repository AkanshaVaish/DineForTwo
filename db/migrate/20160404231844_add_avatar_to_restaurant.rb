class AddAvatarToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :avatar, :string
  end
end
