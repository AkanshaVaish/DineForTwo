class FriendshipsController < ApplicationController
  def create
    friend = Person.find(params[:friend_id])

    Person.transaction do #Ensure both steps happen or neither happen
      Friendship.create!(person: current_user, friend: friend)
      Friendship.create!(person: friend, friend: current_user)
    end
  end
end
