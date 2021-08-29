json.array! @cities do |city|
  json.partial! 'city', city: city
end
