class Concert < ActiveRecord::Base
	validates_presence_of :venue
	validates_presence_of :date

	has_many :reviews
	belongs_to :artist

	paginates_per 15

	#dry these up into 1 function and use class variables? tried a few different things but didn't work
	def averageOverall
		avgOR = 0
		self.reviews.each do |review|
			avgOR = avgOR + review.overallRating
		end
		#not sure if should keep as int or a float, it rounds down at the moment .to_f for float
		return (avgOR.to_f/reviews.size*100).round / 100.0
	end

	def averageSound
		avgSound = 0
		self.reviews.each do |review|
			avgSound += review.sound
		end
		return (avgSound.to_f/reviews.size*100).round / 100.0
	end

	def averageStagePresence
		avgSP = 0
		self.reviews.each do |review|
			avgSP += review.stagePresence
		end
		return (avgSP.to_f/reviews.size*100).round / 100.0
	end

	def averageSongSelection
		avgSS = 0
		self.reviews.each do |review|
			avgSS += review.songSelection
		end
		return (avgSS.to_f/reviews.size*100).round / 100.0
	end
end