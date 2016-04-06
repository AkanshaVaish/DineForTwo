module RestaurantsHelper
  # Returns the current logged in user.
  def current_user
    if (person_id = session[:person_id])
      # If a temporary session exists, use that.
      @current_user ||= Person.find_by(id: person_id)
    elsif (person_id = cookies.signed[:person_id])
      # If cookies exist, use them.
      person = Person.find_by(id: person_id)
      # Extract id from the database.
      if person && person.authenticated?(:remember, cookies[:remember_token])
        # Verify that the cookie matches the remember digest in the database.
        log_in person
        @current_user = person
      end
    end
  end
  def current_user?(user)
    user == current_user
  end
end

