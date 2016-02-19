class SessionsController < ApplicationController
  def new
  end

  def create
    person = Person.authenticate(params[:name], params[:password])
    if person
      session[:person_id] = person.id
      redirect_to root_url, :notice => "Logged In!"
    else
      flash.now.alert ="Invalid email or password"
      render "new"
    end
  end


end
