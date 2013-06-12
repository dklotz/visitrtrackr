json.array!(@visits) do |visit|
  json.extract! visit, :useragent, :latitude, :longitude, :created_at, :updated_at
  json.url visit_url(visit, format: :json)
end