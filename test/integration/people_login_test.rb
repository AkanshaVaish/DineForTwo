require 'test_helper'

class PeopleLoginTest < ActionDispatch::IntegrationTest
  def setup
    @person = people(:john)
  end
  
  test "login with invalid information" do
    get log_in_path
    assert_template 'sessions/new'
    post log_in_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information" do
    get log_in_path
    post log_in_path, session: { email: @person.email, password: 'password' }
    assert_redirected_to @person
    follow_redirect!
    assert_template 'people/show'
    assert_select "a[href=?]", log_in_path, count: 0
    assert_select "a[href=?]", log_out_path
    # Add more paths as they come
  end
end
