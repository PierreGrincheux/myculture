class ChangeLinksOfTargetedValues < ActiveRecord::Migration
  def up
		remove_index :target_values, :control_card_id
		remove_column :target_values, :control_card_id

		add_column :target_values, :greenhouse_id, :integer
		add_index :target_values, :greenhouse_id
  end

	def down
		add_column :target_values, :control_card_id, :integer
		add_index :target_values, :control_card_id

		remove_index :target_values, :greenhouse_id
		remove_column :target_values, :greenhouse_id		
	end
end
