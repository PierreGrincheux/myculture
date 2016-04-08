class TargetValue < ActiveRecord::Base
	belongs_to :user
	belongs_to :value_type
	belongs_to :control_card
end
