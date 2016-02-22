require 'test_helper'

class PeopleSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get sign_up_path # Go to sign up path.
    assert_no_difference 'Person.count' do 
      # Assert that user was not saved to the database.
      post people_path, person: { name:  "",
                               email: "user@invalid",
                               password:              "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'people/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end
  
  test "valid signup information" do
    get sign_up_path
    assert_difference 'Person.count', 1 do
      # Assert that user was saved to the database.
      post_via_redirect people_path, person: { name:  "John Example",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'people/show'
    assert_not flash.empty?
    # Assert that flash is not empty
    assert is_logged_in?
    # Assert that user is logged in after a successful sign up.
  end
end
