require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  
  def setup
    @person = people(:john)
    remember(@person)
  end
  
  test "current_user returns the right user when session is nil" do
    # When session is nil, current_user gets log in info from cookies?
    assert_equal @person, current_user
    assert is_logged_in?
  end
  
  test "current_user returns nil when remember digest is wrong" do
    @person.update_attribute(:remember_digest, Person.digest(Person.new_token))
    # Assign a new remember token and digest to @person in the database.
    assert_nil current_user
  end
  
end