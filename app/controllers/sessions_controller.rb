class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by(name: params[:session][:name])

    if @person && @person.authenticate(params[:session][:password])
      log_in @person
      redirect_to @person
    else
      render 'new'

    end
  end

  def destroy
  end


end
