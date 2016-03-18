class SessionsController < ApplicationController
  def new
  end

  def create
    @person = Person.find_by(email: params[:session][:email])
    if @person && @person.authenticate(params[:session][:password])
      if @person.activated?
        log_in @person
        params[:session][:remember_me] == '1' ? remember(@person) : forget(@person)
        redirect_back_or @person
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid email/password combination."
      # Error message.
      render 'new'
    end
    
    # For Facebook login.
    # begin
    #   @person = Person.from_omniauth(request.env['omniauth.auth'])
    #   session[:user_id] = @person.id
    #   flash[:success] = "Welcome, #{@person.name}!"
    # rescue
    #   flash[:warning] = "There seems to be an error with authentication!"
    # end
      # redirect_to @person
  end

  def destroy
    log_out if logged_in?
    # Prevents errors when attempting to log out from multiple tabs.
    redirect_to root_url
    
    # For Facebook login.
    # if current_user
    #   session.delete(:user_id)
    #   flash[:success] = 'See you!'
    # end
    # redirect_to root_url
  end
end
