class Review < ActiveRecord::Base

	validates_presence_of :artist
	validates_presence_of :venue
	validates_presence_of :date

	belongs_to :user
	belongs_to :concert

end
