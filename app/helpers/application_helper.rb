module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=20"
	end	

	def big_avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=128"
	end	
end
