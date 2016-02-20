module SessionsHelper
  #Logs in the given user
  def log_in(person)
    session[:person_id] = person.id
  end

  #Returns the current logged in user
  def current_user
    @current_user ||= Person.find_by(id: session[:person_id])
  end
end
