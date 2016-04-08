class Value < ActiveRecord::Base
	belongs_to :value_type
	belongs_to :data_card
end
