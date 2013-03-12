class Skill < ActiveRecord::Base
	belongs_to :user

	attr_accessible :name, :user_id

	validates_presence_of :name

	validates_uniqueness_of :name, :scope => :user_id, :case_sensitive => false, :message => "is already in your list"

	HUMANIZED_ATTRIBUTES = {
  		:name => 'Skill'
   	}

  	def self.human_attribute_name(attr, options={})
  		HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  	end
end