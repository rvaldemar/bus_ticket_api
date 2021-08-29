json.array! @paths do |path|
  json.partial! 'route', path: path
end
