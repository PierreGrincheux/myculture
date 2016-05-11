class School < ActiveRecord::Base
has_one :control_card
has_many :user
has_many :greenhouse
has_and_belongs_to_many :media_file
end
