class PeopleController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  # Calls logged_in_user before edit and update actions.
  before_action :correct_user, only: [:edit, :update]
  # Calls correct_user before edit and update actions.

  def index
    @people = Person.paginate(page: params[:page])
    # params[:page] is automatically provided by will_paginate
  end

  # Method to show the user profile
  def show
    @person = Person.find(params[:id])
  end

  # Method new to create a new sign up
  def new
    @person = Person.new
  end

  # Method create to save the user
  def create
    @person = Person.new(person_params)
    # If saved succesfully should go back to root_url and output signed up.
    if @person.save
      log_in @person # Logs in the user after a successful sign up.
      flash[:success] = "Successfully signed up for Dine for Two!"
      redirect_to @person # Render user's profile.
    else
      render 'new'
    end
  end

  # Method to pop up the current user profile and allow user to edit it.
  def edit
  end

  # Method post the changes we made to the user using edit action.
  def update
    if @person.update_attributes(person_params)
      # Handle a successful update.
      flash[:success] = "Profile updated!"
      redirect_to @person
    else
      render 'edit'
    end
  end

  # Method delete user's account data
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to root_url, :notice => "Your Profile has been deleted."
  end

  private
  
    def person_params
      params.require(:person).permit(:email, :name, 
                                      :password, :password_confirmation)
    end
    
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to log_in_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @person = Person.find(params[:id])
      redirect_to(root_url) unless current_user?(@person)
    end

end
