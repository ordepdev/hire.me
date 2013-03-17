class Profile < ActiveRecord::Base
	  belongs_to :user

  	attr_accessible :birthday, :first_name, :last_name, :location, :motivation, :photo, :user_id, :profile_attributes

  	validates_presence_of :first_name, :last_name

  	def full_name
  		first_name + " " + last_name
  	end

  	def age
  		Date.today.year - birthday.year - ((Date.today.month > birthday.month || (Date.today.month == birthday.month && Date.today.day >= birthday.day)) ? 0 : 1)
  	end

    def email 
      User.find(user_id).email
    end

    def user
      User.find(user_id)
    end

  	def skills
		  Skill.find_all_by_user_id(user_id).map(&:name).join(', ')
  	end

    def users_from_same_location
      Profile.where("location = ?", location).map(&:user_id)
    end

    def self.top_locations
      Profile.count(:group => 'location', :limit => 5)
    end

    def self.random_motivation
      Profile.all_filtered.sample(1).map(&:motivation).first
    end

    def self.birthdays
      Profile.where("birthday = ?", Date.today)
    end

    def self.educations(id)
      Education.order("graduation_date DESC").where("graduation_date is null and user_id = ?", id) +
       Education.order("graduation_date DESC").where("graduation_date is not null and user_id = ?", id)
    end

    def educations
      Education.order("graduation_date DESC").where("graduation_date is null and user_id = ?", user_id) +
       Education.order("graduation_date DESC").where("graduation_date is not null and user_id = ?", user_id)
    end

    def completed?
      location.present? && motivation.present? && birthday.present?
    end

    def self.all_filtered
      Profile.where("location is not null and motivation is not null and birthday is not null").all
    end
end
