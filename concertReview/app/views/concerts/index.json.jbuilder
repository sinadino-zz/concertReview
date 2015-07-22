json.array!(@concerts) do |concert|
  json.extract! concert, :id, :artist, :venue, :date
  json.url concert_url(concert, format: :json)
end
