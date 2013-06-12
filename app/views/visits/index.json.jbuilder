json.array!(@visits) do |visit|
  json.extract! visit, :useragent, :lat, :long
  json.url visit_url(visit, format: :json)
end