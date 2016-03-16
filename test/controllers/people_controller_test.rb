require 'test_helper'

class PeopleControllerTest < ActionController::TestCase

  def setup
    @person = people(:john)
    @other_person = people(:lana)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to log_in_url
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should redirect edit when not logged in" do
    assert_not is_logged_in?
    get :edit, id: @person
    assert_not flash.empty?
    assert_redirected_to log_in_url
  end

  test "should redirect update when not logged in" do
    assert_not is_logged_in?
    patch :update, id: @person, person: { name: @person.name, email: @person.email }
    # The person hash is required for the routes to work properly.
    assert_not flash.empty?
    assert_redirected_to log_in_url
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_person)
    assert is_logged_in?
    get :edit, id: @person
    assert flash.empty?
    assert_redirected_to root_url
    # Redirect to root url because the user is already logged in.
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_person)
    assert is_logged_in?
    patch :update, id: @person, person: { name: @person.name, email: @person.email }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_not is_logged_in?
    assert_no_difference 'Person.count' do
      delete :destroy, id: @person
    end
    assert_redirected_to log_in_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_person)
    assert is_logged_in?
    assert_no_difference 'Person.count' do
      delete :destroy, id: @person
    end
    assert_redirected_to root_url
  end
  
end
