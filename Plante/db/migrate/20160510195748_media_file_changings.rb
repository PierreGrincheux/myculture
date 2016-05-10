class MediaFileChangings < ActiveRecord::Migration
  def up
		add_column :media_files, :attachement, :string
		remove_column :media_files, :path
  end

	def down
		remove_column :media_files, :attachement
		add_column :media_files, :path, :string
	end
end
