class ControlCard < ActiveRecord::Base
belongs_to :school
has_many :data_card
has_many :user
has_and_belongs_to_many :media_file
end
