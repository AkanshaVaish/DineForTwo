require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @person = people(:john)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_resets_path, password_reset: { email: "" }
    # Invalid email
    assert_not flash.empty?
    assert_template 'password_resets/new'
    post password_resets_path, password_reset: { email: @person.email }
    # Valid email
    assert_not_equal @person.reset_digest, @person.reload.reset_digest
    # Check that a new reset_digest has been generated.
    assert_equal 1, ActionMailer::Base.deliveries.size
    # Check that only 1 email was delivered.
    assert_not flash.empty?
    assert_redirected_to root_url
    
    # Password reset form
    person = assigns(:person)
    # assigns allows the assigned variable to access instance variables
    # defined in the corresponding controller.
    get edit_password_reset_path(person.reset_token, email: "") # Wrong email
    assert_redirected_to root_url
    person.toggle!(:activated)
    # Simulate an inactive user
    get edit_password_reset_path(person.reset_token, email: person.email)
    assert_redirected_to root_url
    person.toggle!(:activated) # Reactive user.
    get edit_password_reset_path('wrong token', email: person.email)
    # Right email, wrong token
    assert_redirected_to root_url
    get edit_password_reset_path(person.reset_token, email: person.email)
    # Right email, right token
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", person.email
    # Check that the hidden field containing the user's email is present.
    patch password_reset_path(person.reset_token),
          email: person.email,
          person: { password:              "foobaz",
                  password_confirmation: "barquux" }
    # Invalid password & confirmation
    assert_select 'div#error_explanation'
    patch password_reset_path(person.reset_token),
          email: person.email,
          person: { password:              "",
                  password_confirmation: "" }
    # Empty password
    assert_select 'div#error_explanation'
    patch password_reset_path(person.reset_token),
          email: person.email,
          person: { password:              "foobaz",
                  password_confirmation: "foobaz" }
    # Valid password & confirmation
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to person
  end
end