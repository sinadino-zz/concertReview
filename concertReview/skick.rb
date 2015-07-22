require 'songkickr'
remote = Songkickr::Remote.new 'WrlX22JJAxW2489I'

#@results = remote.artist_search('The Knife').results.first
#puts @results.id

#@res = remote.artist_events('246981', :per_page => '10').results
#@res.each do |d|
#	puts d.display_name
#end

@loc = remote.location_search('San Francisco, CA').results
@loc.each do |location|
	puts location.city + ": " + "#{location.metro_area.id}"
end

#@sf = remote.metro_areas_events('26330', :per_page => '10').results
#@sf.each do |event|
#	puts event.display_name + ": " + event.tickets_uri.to_s
#end
#@results.each do |result|
#  print result.display_name + "\n"
#end