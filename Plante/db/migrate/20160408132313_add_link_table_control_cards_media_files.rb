class AddLinkTableControlCardsMediaFiles < ActiveRecord::Migration
  def up
		#create_table :control_cards_media_files do |t|
		#	t.integer :control_card_id
		#	t.integer :media_file_id
		#end

		#add_index :control_cards_media_files, :control_card_id
		#add_index :control_cards_media_files, :media_file_id

		add_column :data_cards, :position, :integer
		add_column :values, :created_at, :datetime
		add_column :target_values, :created_at, :datetime
		add_column :media_files, :created_at, :datetime

  end

	def down 
		#remove_index :control_cards_media_files, :control_card_id
		#remove_index :control_cards_media_files, :media_file_id

		#drop_table :control_cards_media_files

		#remove_column :data_cards, :position
		#remove_column :values, :created_at
		#remove_column :target_values, :created_at
		#remove_column :media_files, :created_at
	end
end
