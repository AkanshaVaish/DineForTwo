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
  
  test "login with valid information followed by logout" do
    get log_in_path
    post log_in_path, session: { email: @person.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @person
    follow_redirect!
    assert_template 'people/show'
    assert_select "a[href=?]", log_in_path, count: 0
    assert_select "a[href=?]", log_out_path
    assert_select "a[href=?]", person_path(@person)
    # Add more paths as they come
    delete log_out_path
    assert_not is_logged_in? # Log out is successful.
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", log_in_path, count: 1
    assert_select "a[href=?]", log_out_path, count: 0
    assert_select "a[href=?]", person_path(@person), count: 0
  end
end
