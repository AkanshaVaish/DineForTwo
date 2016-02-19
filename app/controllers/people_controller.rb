class PeopleController < ApplicationController

  #Method to show the user profile
  def show
    @person = Person.find(params[:id])
  end

  #Method new to create a new sign up
  def new
    @person = Person.new
  end

  #Method create to save the user
  def create
    @person = Person.new(person_params)
    #if saved succesfully should go back to root_url and output signed up
    if @person.save
      redirect_to @person
    else
      render 'new'
    end
  end

  private
    def person_params
      params.require(:person).permit(:email, :name, :password, :password_confirmation)
    end


end
