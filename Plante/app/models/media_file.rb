class MediaFile < ActiveRecord::Base
	belongs_to :user
	belongs_to :media_file_type
	has_and_belongs_to_many :control_card #Ne sert a rien
	has_and_belongs_to_many :school

	mount_uploader :attachement
end
