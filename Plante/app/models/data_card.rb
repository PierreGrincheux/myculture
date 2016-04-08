class DataCard < ActiveRecord::Base
	belongs_to :control_card
	belongs_to :greenhouse
	has_many :value
end
