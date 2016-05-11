class MediaFileUpdate < ActiveRecord::Migration
  def up
		create_table :media_files_schools do |t|
			t.integer :school_id
			t.integer :media_file_id
		end

		add_index :media_files_schools, :school_id
		add_index :media_files_schools, :media_file_id

		add_column :media_files, :to_show, :boolean, :default => true
  end

	def down
		remove_column :media_files, :to_show
		
		remove_index :media_files_schools, :school_id
		remove_index :media_files_schools, :media_file_id

		drop_table :media_files_schools
	end
end
