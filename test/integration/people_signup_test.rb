require 'test_helper'

class PeopleSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    # Because the deliveries array is global, we have to reset it to prevent
    # our code from breaking if other tests try to deliver mail.
  end
  
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
  
  test "valid signup information with account activation" do
    get sign_up_path
    assert_difference 'Person.count', 1 do
      # Assert that user was saved to the database.
      post people_path, person: { name:  "John Example",
                                  email: "user@example.com",
                                  password:              "password",
                                  password_confirmation: "password" }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    # Check that only 1 email is delivered.
    person = assigns(:person) 
    # assigns allows access to instance variables defined in the people controller.
    assert_not person.activated?
    log_in_as(person)
    # Try to log in before activation.
    assert_not is_logged_in?
    get edit_account_activation_path("invalid token")
    # Invalid activation token.
    assert_not is_logged_in?
    get edit_account_activation_path(person.activation_token, email: 'wrong')
    # Valid token, wrong email.
    assert_not is_logged_in?
    get edit_account_activation_path(person.activation_token, email: person.email)
    # Valid activation token, valid email.
    assert person.reload.activated?
    # Reload the user from the database and check if activated.
    follow_redirect!
    assert_template 'people/show'
    assert_not flash.empty?
    assert is_logged_in?
  end
  
end
