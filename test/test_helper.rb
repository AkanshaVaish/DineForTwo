ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Logs in a test user.
  def log_in_as(person, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post log_in_path, session: { email: person.email,
                                    password: password,
                                    remember_me: remember_me }
    else
      session[:user_id] = person.id
    end
  end

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:person_id].nil?
  end
  
  # Returns true inside an integration test.
  def integration_test?
    defined?(post_via_redirect)
  end
end
