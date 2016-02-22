require 'test_helper'

class PeopleLoginTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:john)
  end
  
  test "login with valid information" do
    get log_in_path
    post log_in_path, session: { name: @person.email, password: 'password' }
    assert_redirected_to @person
    follow_redirect!
    assert_template 'people/show'
    assert_select "a[href=?]", log_in_path, count: 0
    assert_select "a[href=?]", log_out_path
    # Add more paths as they come
  end
end
