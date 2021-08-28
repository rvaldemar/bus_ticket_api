require "test_helper"

class BusTest < ActiveSupport::TestCase
  test "should save bus with seats a number of seats" do
    bus = Bus.new seats: 123
    assert bus.save
  end

  test "should save bus with default seats" do
    bus = Bus.new
    assert bus.save
  end

  test "should not save bus without seats " do
    bus = Bus.new seats: nil
    assert_not bus.save
  end

  test "should not save bus with seats as float " do
    bus = Bus.new seats: 1.23
    assert_not bus.save
  end

  test "should save bus seats as integer " do
    bus = Bus.new seats: '12'
    assert bus.save && bus.seats.is_a?(Integer)
  end
end
