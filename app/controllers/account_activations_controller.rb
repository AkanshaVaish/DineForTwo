class AccountActivationsController < ApplicationController

  def edit
    person = Person.find_by(email: params[:email])
    if person && !person.activated? && 
                              person.authenticated?(:activation, params[:id])
      # Checks if user is activated, because we don’t want to allow attackers 
      # who manage to obtain the activation link to log in as the user.
      person.activate # Class method.
      log_in person # Sessions helper method.
      flash[:success] = "Account activated!"
      redirect_to person
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

end
