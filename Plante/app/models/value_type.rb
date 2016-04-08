class ValueType < ActiveRecord::Base
	has_many :target_value
	has_many :value
end
