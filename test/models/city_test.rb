require "test_helper"

class CityTest < ActiveSupport::TestCase
  test "should save city with name as a string" do
    city = City.new name: 'Braga'
    assert city.save
  end

  test "should not save city with name black " do
    city = City.new name: ''
    assert_not city.save
  end

  test "should not save city without name " do
    city = City.new name: nil
    assert_not city.save
  end

  test "should save city name as string " do
    city = City.new name: 12
    assert city.save && city.name.is_a?(String)
  end
end
