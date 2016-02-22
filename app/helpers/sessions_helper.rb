module SessionsHelper
  # Logs in the given user.
  def log_in(person)
    session[:person_id] = person.id
  end

  # Returns the current logged in user.
  def current_user
    @current_user ||= Person.find_by(id: session[:person_id])
  end
  
  # Returns true if the user is logged in.
  # Handy for changing layout links when logged in.
  def logged_in?
    !current_user.nil?
  end
  
  def log_out
    session.delete(:person_id)
    @current_user = nil
    # Sets current user to nil, just in case.
  end
end
