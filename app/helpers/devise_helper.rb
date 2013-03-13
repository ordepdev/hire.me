module DeviseHelper
	def devise_error_messages!
		messages = []
	    return "" if resource.errors.empty? 
	    resource.errors.full_messages.each	do |msg|
	    	messages << ' * ' + msg
	    end
	    flash.now[:error] = messages.join("<br />").html_safe
	end 
end