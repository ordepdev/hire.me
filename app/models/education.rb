class Education < ActiveRecord::Base
  	belongs_to :user
  	
  	attr_accessible :course, :graduation_date, :school, :title, :user_id

  	validates_presence_of :school, :title, :course, :user_id

  	validates_format_of :graduation_date, 
  		:with => /(19|20)\d{2}/i,
  		:message => "should be a four-digit year" if :graduation_date.present?

  	validates_inclusion_of :graduation_date, 
  		:in => 1990..Date.today.year

  	HUMANIZED_ATTRIBUTES = {
  		:graduation_date => 'Graduation date',
  		:title => 'Title'
  	}

  	def self.human_attribute_name(attr, options={})
  		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  	end
end
