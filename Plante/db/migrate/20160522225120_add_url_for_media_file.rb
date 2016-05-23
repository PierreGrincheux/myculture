class AddUrlForMediaFile < ActiveRecord::Migration
  def up
		add_column :media_files, :path, :string
		MediaFileType.create(name: "timelapse_photo", translated_name: "Photo du timelapse")
  end

	def down
		remove_column :media_files, :path
		MediaFileType.where(name: 'timelapse_photo').first.destroy
	end
end
