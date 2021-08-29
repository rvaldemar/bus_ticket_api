require "test_helper"

class RouteTest < ActiveSupport::TestCase
  test "should save route with bus_id, start_id, destination_id, start_date, end_date" do

    braga = City.new name: 'Braga'
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    braga.save
    lisbon.save
    bus.save

    route = Route.new(
      bus_id: bus.id,
      start_id: braga.id,
      destination_id: lisbon.id,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    assert route.save
  end

  test "should not save route with destination_id blank " do
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    lisbon.save
    bus.save

    route = Route.new(
      bus_id: bus.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    assert_not route.save
  end

  test "should not save route with start_id blank " do
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    lisbon.save
    bus.save

    route = Route.new(
      bus_id: bus.id,
      destination_id: lisbon.id,
      start_id: nil,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    assert_not route.save
  end

  test "should not save route with start_date < end_date " do
    braga = City.new name: 'Braga'
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    braga.save
    lisbon.save
    bus.save

    time = Time.now

    route1 = Route.new(
      bus_id: bus.id,
      destination_id: lisbon.id,
      start_id: braga.id,
      start_date: time,
      end_date: time
    )

    route2 = Route.new(
      bus_id: bus.id,
      destination_id: lisbon.id,
      start_id: braga.id,
      start_date: time,
      end_date: time - 1.day
    )

    assert_not route1.save || route2.save
  end

  test "should not save route with destination_id == start_id " do
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    lisbon.save
    bus.save

    route = Route.new(
      bus_id: bus.id,
      destination_id: lisbon.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    assert_not route.save
  end

  test "should not save route with start_id != last route destination_id " do
    braga = City.new name: 'Braga'
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    braga.save
    lisbon.save
    bus.save

    route1 = Route.new(
      bus_id: bus.id,
      destination_id: braga.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    route1.save

    route2 = Route.new(
      bus_id: bus.id,
      destination_id: braga.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: Time.now + 1.day
    )

    assert_not route2.save
  end

  test "should not save route with start_date <= last route end_date + 5.minutes " do
    braga = City.new name: 'Braga'
    lisbon = City.new name: 'Lisbon'
    bus = Bus.new seats: 123

    braga.save
    lisbon.save
    bus.save

    time = Time.now

    route1 = Route.new(
      bus_id: bus.id,
      destination_id: braga.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: time
    )

    route1.save

    route2 = Route.new(
      bus_id: bus.id,
      destination_id: braga.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: time + 5.minutes
    )

    route3 = Route.new(
      bus_id: bus.id,
      destination_id: braga.id,
      start_id: lisbon.id,
      start_date: Time.now,
      end_date: time + 1.minute
    )

    assert route2.save && !route3.save
  end
end
