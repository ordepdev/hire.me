require 'net/http'
require 'rexml/document'

class HomeController < ApplicationController
	def index

	end

	def random
		profiles = Profile.all.map(&:id)
		previous = session[:previous]
		if profiles.count == 1
			@profile = Profile.find(profiles.sample)
			@user = User.find(@profile.user_id)
		else
			@profile = Profile.find((profiles - [previous]).sample)
			@user = User.find(@profile.user_id)
			session[:previous] = @profile.id
		end
		
		respond_to do |format|
			format.html
			format.js
		end
	end

	def about
	end

	def developers
		@profiles = Profile.all_filtered
	end

	def jobs
		# itjobs feed url
		url = 'http://feeds.itjobs.pt/feed/ofertas?location=18,14,1,8,4,17,13,6,22,10,20,16,9,3'

		# extract info from xml
		xml_data = Net::HTTP.get_response(URI.parse(url)).body
		doc = REXML::Document.new(xml_data)
		@descriptions 	= []
		@links 			= []

		doc.elements.each('rss/channel/item/description') do |e|			
			@descriptions << e.text
		end

		doc.elements.each('rss/channel/item/link') do |e|			
			@links << e.text
		end

	end
end
