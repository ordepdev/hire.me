class ApplicationController < ActionController::Base
  	protect_from_forgery
  	
    def error_messages(model)
  		messages = []
  	    return "" if model.errors.empty? 
  	    model.errors.full_messages.each	do |msg|
  	    	messages << ' * ' + msg
  	    end
  	    flash[:error] = messages.join("<br />").html_safe
  	end 
end
