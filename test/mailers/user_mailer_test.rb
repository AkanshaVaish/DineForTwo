require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  test "account_activation" do
    person = people(:john)
    person.activation_token = Person.new_token
    mail = UserMailer.account_activation(person)
    assert_equal "Account activation", mail.subject
    assert_equal [person.email], mail.to
    assert_equal ["noreply@dinefortwo.com"], mail.from
    assert_match person.name,               mail.body.encoded
    assert_match person.activation_token,   mail.body.encoded
    assert_match CGI::escape(person.email), mail.body.encoded
    # Escapes the @ in the email.
    # assert_match returns true if the LHS string is in the RHS string.
  end
  
  test "password_reset" do
    person = people(:john)
    person.reset_token = Person.new_token
    mail = UserMailer.password_reset(person)
    assert_equal "Password reset", mail.subject
    assert_equal [person.email], mail.to
    assert_equal ["noreply@dinefortwo.com"], mail.from
    assert_match person.reset_token,        mail.body.encoded
    assert_match CGI::escape(person.email), mail.body.encoded
  end
  
end
