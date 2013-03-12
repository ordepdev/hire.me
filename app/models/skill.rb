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

  	def top5 
  		Skill.count(:group => 'name', :limit => 5)
  		# skills = ...
  		# skills.each {|skill| 
  		# 	puts 'Skill => ' + skill[0] 
  		# 	puts 'Count => ' + skill[1]
  		# }
	end

	def users_with_same_skill(skill)
		Skill.where("name = #{skill}").map(&:user_id)
		# users = ...
		# users.each {|user|}
		# 	Profile.find_by_user_id(user.id)
		# ...
	end
end