class PeopleController < ApplicationController

  def index
    @person =Person.all
  end
  
  #Method to show the user profile
  def show
    @person = Person.find(params[:id])
  end
  
  #Method pop up the current user profile and allow user to edit it
  def edit
    @person = Person.find(params[:id])
  end
  
  #Method new to create a new sign up
  def new
    @person = Person.new
  end

  # Method create to save the user
  def create
    @person = Person.new(person_params)
    # if saved succesfully should go back to root_url and output signed up
    if @person.save
      log_in @user # Logs in the user after a successful sign up
      flash[:success] = "Successfully signed up for Dine for Two!"
      redirect_to @person
    else
      render 'new'
    end
  end
  
  #Method updates the user data to DB
  def update
    @person =  Person.find(params[:id])
    
    if @person.update_attributes(person_edit_params)
      redirect_to @person, :notice => "Update success"
    else
      render 'edit'
    end
  end
  
  #Method delete user's account data
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to root_url, :notice => "Your Profile has been deleted."
  end

  private
    def person_params
      params.require(:person).permit(:email, :name, :password, :password_confirmation)
    end
    
    #Parameters allowed for edit
    def person_edit_params
      params.require(:person).permit(:email, :name)
    end
    


end
