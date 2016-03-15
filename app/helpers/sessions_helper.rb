module SessionsHelper
  # Logs in the given user.
  def log_in(person)
    session[:person_id] = person.id
  end

  # Remembers a user in a persistent session.
  def remember(person)
    person.remember
    # Generates a remember_token and saves its hash in the database.
    # Defined in person.rb.
    cookies.permanent.signed[:person_id] = person.id
    cookies.permanent[:remember_token] = person.remember_token
    # Encrypts id and remember_token and saves them as cookies.
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged in user.
  def current_user
    if (person_id = session[:person_id])
      # If a temporary session exists, use that.
      @current_user ||= Person.find_by(id: person_id)
    elsif (person_id = cookies.signed[:person_id])
      # If cookies exist, use them.
      person = Person.find_by(id: person_id)
      # Extract id from the database.
      if person && person.authenticated?(cookies[:remember_token])
        # Verify that the cookie matches the remember digest in the database.
        log_in person
        @current_user = person
      end
    end
  end

  # Returns true if the user is logged in.
  # Handy for changing layout links when logged in.
  def logged_in?
    !current_user.nil?
  end

  def forget(person)
    person.forget
    # Sets the user's remember digest to nil.
    # Defined in person.rb.
    cookies.delete(:person_id)
    cookies.delete(:remember_token)
    # Clear the cookies.
  end

  def log_out
    forget(current_user)
    # Forgets the user in the database and clears any cookies.
    session.delete(:person_id)
    @current_user = nil
    # Sets current user to nil, just in case.
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
    # Delete after the redirect so that the user will not be forwarded to the
    # same URL upon each login attempt.
    # Redirects always wait for the rest of the code block to return before
    # actually redirecting.
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
    # Makes sure that the URL is saved only for a GET request because submitting
    # DELETE, PATCH or POST will raise errors when the URL is expecting
    # a GET request.
  end
  
end
