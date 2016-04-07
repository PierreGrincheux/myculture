class AddNewFk < ActiveRecord::Migration
  def up	
		add_column :control_cards, :school_id, :integer
		add_index :control_cards, :school_id
  end

	def down
		remove_index :control_cards, :school_id
		remove_column :control_cards, :school_id
	end
end
