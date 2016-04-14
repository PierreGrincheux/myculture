class AddNewFk < ActiveRecord::Migration
  def up	
		add_column :control_cards, :school_id, :integer
		add_index :control_cards, :school_id
		add_column :data_cards, :control_card_id, :integer
		add_index :data_cards, :control_card_id
  end

	def down
		remove_index :control_cards, :school_id
		remove_column :control_cards, :school_id
		remove_index :data_cards, :control_card_id
		remove_column :data_cards, :control_card_id
	end
end
