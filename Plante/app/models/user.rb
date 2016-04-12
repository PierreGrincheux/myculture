class User < ActiveRecord::Base
	belongs_to :school
	belongs_to :control_card
	has_many :target_value
	has_many :file
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

	def self.super_admin?
		return self.super_admin
	end

	def self.teacher?
		return self.teacher
	end
end
