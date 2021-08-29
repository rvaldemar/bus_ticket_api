# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


10.times do
  p 'Creating a bus...'
  Bus.create!
end

10.times do
  p 'Creating a bus...'
  Bus.create!(seats: rand(48) + 9)
end

100.times do
  p 'Creating a city...'
  City.create(name: Faker::Address.city)
end

last_operation_end_date = Route.maximum(:end_date) || 0

while last_operation_end_date.year < 2022
  bus = Bus.find(rand(1..Bus.count))
  last_route = bus.last_route

  start_id = last_route ? last_route.destination_id : rand(1..City.count)
  destination_id = rand(1..City.count)

  while start_id == destination_id
    destination_id = rand(1..City.count)
  end

  commute_time = Route.commute_time(start_id, destination_id) || 15*60 + rand(60*60*4)

  start_date = last_route ? last_route.end_date + 5.minutes + rand(60*60*24) : Time.now
  end_date = start_date + commute_time

  p 'Creating a route...'
  Route.create!(
    bus_id: bus.id,
    start_id: start_id,
    destination_id: destination_id,
    start_date: start_date,
    end_date: end_date
  )

  last_operation_end_date = Route.maximum(:end_date)
end



