class Greenhouse < ActiveRecord::Base
	belongs_to :school
	has_many :data_card
end
