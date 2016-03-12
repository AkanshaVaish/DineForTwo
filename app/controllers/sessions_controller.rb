class SessionsController < ApplicationController
  def new
  end

  def create
    begin
      @person = Person.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @person.id
      flash[:success] = "Welcome, #{@person.name}!"
    rescue
      flash[:warning] = "There seems to be an error with authentication!"
    end
      redirect_to @person
  end

  def destroy
    log_out if logged_in?
    # Prevents errors when attempting to log out from multiple tabs.
    redirect_to root_url
  end
end
