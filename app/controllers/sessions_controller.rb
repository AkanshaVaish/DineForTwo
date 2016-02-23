class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by(email: params[:session][:email])
    if @person && @person.authenticate(params[:session][:password])
      log_in @person
      params[:session][:remember_me] == '1' ? remember(@person) : forget(@person)
      redirect_to @person
    else
      flash.now[:danger] = "Invalid email/password combination."
      # Error message.
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    # Prevents errors when attempting to log out from multiple tabs.
    redirect_to root_url
  end
end
