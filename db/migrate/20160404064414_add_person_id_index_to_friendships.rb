class AddPersonIdIndexToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :person_id, :integer
    add_index:friendships, [:person_id, :friend_id], :unique => true
  end
end
