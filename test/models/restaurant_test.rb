require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  def setup
    @restaurant = Restaurant.new(name: "Example Restaurant",
                          description: "Example description.")
  end
  
  # Tests that setup is successful.
  test "should be valid" do
    assert @restaurant.valid?
  end
  
  test "name should be present" do
    @restaurant.name = "   "
    assert_not @restaurant.valid?
  end
  
  test "description should be present" do
    @restaurant.description = "   "
    assert_not @restaurant.valid?
  end
end
