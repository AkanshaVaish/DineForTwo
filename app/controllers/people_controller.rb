class PeopleController < ApplicationController
  #Method new to create a new sign up
  def new
    @person = Person.new
  end

  #Method create to save the user
  def create
    @person = Person.new(person_params)

    if @person.save
      reredirect to root_url, :notice => "signed up"
    else
      render 'new'
    end
  end

  private
    def person_params
      params.require(:person).permit(:email, :name, :password_hash, :salt)
    end


end
