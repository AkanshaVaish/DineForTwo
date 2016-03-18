class PeopleController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # Calls logged_in_user before index, edit, update and destroy actions.
  # Before actions are applied to all actions by default.
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @people = Person.paginate(page: params[:page])
    # params[:page] is automatically generated by will_paginate.
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
      UserMailer.account_activation(@person).deliver_now
      # Send the account activation email.
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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

  def destroy
    Person.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to people_url
  end

  private
  
    def person_params
      params.require(:person).permit(:email, :name, 
                                      :password, :password_confirmation)
    end
    
    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in? # Sessions helper method.
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

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
