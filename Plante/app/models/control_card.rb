class ControlCard < ActiveRecord::Base
belongs_to :school
has_many :data_card
has_many :user
has_many :target_value
end
