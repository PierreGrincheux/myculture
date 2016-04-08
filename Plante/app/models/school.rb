class School < ActiveRecord::Base
has_one :control_card
has_many :user
has_many :greenhouse
end
