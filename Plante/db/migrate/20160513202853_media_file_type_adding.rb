class MediaFileTypeAdding < ActiveRecord::Migration
  def up
		create_table :media_file_types do |f|
			f.string :name
			f.string :translated_name
		end

		add_column :media_files, :media_file_type_id, :integer

		add_index :media_files, :media_file_type_id

		MediaFileType.create(name: "tp", translated_name: "Travaux Pratiques")
		MediaFileType.create(name: "td", translated_name: "Travaux Dirigés")
		MediaFileType.create(name: "course", translated_name: "Cours")
		
  end

	def down
		drop_table :media_file_types

		remove_index :media_files, :media_file_type_id
		
		remove_column :media_files, :media_file_type_id
	end
end
