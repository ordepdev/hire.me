class User < ActiveRecord::Base
	has_one :profile, :dependent => :destroy
	has_many :skill, :dependent => :destroy
	has_many :education, :dependent => :destroy

	accepts_nested_attributes_for :profile

	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	       :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :email, :password, :password_confirmation, :remember_me, :profile_attributes, :skill_attributes
	# attr_accessible :title, :body
end
