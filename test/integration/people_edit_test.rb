require 'test_helper'

class PeopleEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @person = people(:john)
  end

  test "unsuccessful edit" do
    get edit_person_path(@person)
    assert_template 'people/edit'
    patch person_path(@person), person: { name:  "",
                                    email: "foo@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" }
    assert_template 'people/edit'
  end

  test "successful edit" do
    get edit_person_path(@person)
    assert_template 'people/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch person_path(@person), person: { name:  name, email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @person
    @person.reload
    assert_equal name,  @person.name
    assert_equal email, @person.email
  end

end
