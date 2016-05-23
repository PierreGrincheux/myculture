class AddUrlForMediaFile < ActiveRecord::Migration
  def up
		add_column :media_files, :path, :string
		add_column :media_files, :greenhouse_id, :integer
		add_index :media_files, :greenhouse_id
		MediaFileType.create(name: "timelapse_photo", translated_name: "Photo du timelapse")
  end

	def down
		remove_column :media_files, :path
		remove_index :media_files, :greenhouse_id
		remove_column :media_files, :greenhouse_id
		MediaFileType.where(name: 'timelapse_photo').first.destroy
	end
end
