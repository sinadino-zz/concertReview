require 'songkickr'
class Artist < ActiveRecord::Base
	extend FriendlyId

	friendly_id :name
	validates_presence_of :name
	has_many :concerts

	paginates_per 15


	def upcomingEvents

		@remote = Songkickr::Remote.new 'WrlX22JJAxW2489I'

		artistId = @remote.artist_search(self.name).results.first

		getId = artistId.id if !artistId.to_s.empty?
		
		if(getId != nil)
			artistConcerts = @remote.artist_events(getId, :per_page => '10').results
		end

		return artistConcerts
	end

	def self.search(query)
  		where("name like ?", "%#{query}%") 
	end

	def avgOverall
		avg = 0
		self.concerts.each do |concert|
			avg = avg + concert.averageOverall
		end
		return (avg/concerts.size*100).round / 100.0
	end

	def avgSound
		avg = 0
		self.concerts.each do |concert|
			avg = avg + concert.averageSound
		end
		return (avg/concerts.size*100).round / 100.0
	end

	def avgStagePresence
		avg = 0
		self.concerts.each do |concert|
			avg = avg + concert.averageStagePresence
		end
		return (avg/concerts.size*100).round / 100.0
	end

	def avgSongSelection
		avg = 0
		self.concerts.each do |concert|
			avg = avg + concert.averageSongSelection
		end
		return (avg/concerts.size*100).round / 100.0
	end

	def numReviews
		artistReviews = 0
		self.concerts.each do |concert|
			artistReviews += concert.reviews.size
		end
		return artistReviews
	end

end