class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by(email: params[:session][:email])
    if @person && @person.authenticate(params[:session][:password])
      log_in @person
      redirect_to @person
    else
      flash.now[:danger] = "Invalid email/password combination."
      # Error message.
      render 'new'
    end
  end

  def destroy
  end
end
