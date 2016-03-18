require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = Person.new(name: "Example User", email: "example@dinefortwo.com",
                          password: "foobar", password_confirmation: "foobar")
  end
  
  # Tests that setup is successful.
  test "should be valid" do
    assert @person.valid?, "#{@person.email.inspect} already exists."
    # Because the only parameter that needs to be unique in our setup in email.
    # inspect prints the string representation of a given object.
  end
  
  test "name should be present" do
    @person.name = "   "
    assert_not @person.valid?
  end
  
  test "email should be present" do
    @person.email = "   "
    assert_not @person.valid?
  end
  
  test "name should not be too long" do
    @person.name = "j" * 61
    assert_not @person.valid?
  end

  test "email should not be too long" do
    @person.email = "j" * 244 + "@example.com"
    assert_not @person.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @person.email = valid_address
      assert @person.valid?, "#{valid_address.inspect} should be valid"
      # Message to output if test fails
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @person.email = invalid_address
      assert_not @person.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_person = @person.dup
    duplicate_person.email = @person.email.upcase
    @person.save
    assert_not duplicate_person.valid?
  end
  
  test "password should be present (nonblank)" do
    @person.password = @person.password_confirmation = " " * 6
    assert_not @person.valid?
  end
  
  test "password should have a minimum length" do
    @person.password = @person.password_confirmation = "a" * 5
    assert_not @person.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @person.authenticated?(:remember, '')
  end
end
