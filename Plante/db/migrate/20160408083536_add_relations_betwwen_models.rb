class AddRelationsBetwwenModels < ActiveRecord::Migration
  def up	
		add_column :users, :school_id, :integer
		add_column :users, :control_card_id, :integer
		add_column :media_files, :user_id, :integer
		add_column :target_values, :user_id, :integer
		add_column :target_values, :value_type_id, :integer
		add_column :target_values, :control_card_id, :integer
		add_column :values, :value_type_id, :integer
		add_column :values, :data_card_id, :integer
		add_column :data_cards, :greenhouse_id, :integer
		add_column :greenhouses, :school_id, :integer

		add_index :users, :school_id
		add_index :users, :control_card_id
		add_index :media_files, :user_id
		add_index :target_values, :user_id
		add_index :target_values, :value_type_id
		add_index :target_values, :control_card_id
		add_index :values, :value_type_id
		add_index :values, :data_card_id
		add_index :data_cards, :greenhouse_id
		add_index :greenhouses, :school_id



		
  end

	def down
		remove_index :users, :school_id
		remove_index :users, :control_card_id
		remove_index :media_files, :user_id
		remove_index :target_values, :user_id
		remove_index :target_values, :value_type_id
		remove_index :target_values, :control_card_id
		remove_index :values, :value_type_id
		remove_index :values, :data_card_id
		remove_index :data_cards, :greenhouse_id
		remove_index :greenhouses, :school_id

		remove_column :users, :school_id
		remove_column :users, :control_card_id
		remove_column :media_files, :user_id
		remove_column :target_values, :user_id
		remove_column :target_values, :value_type_id
		remove_column :target_values, :control_card_id
		remove_column :values, :value_type_id
		remove_column :values, :data_card_id
		remove_column :data_cards, :greenhouse_id
		remove_column :greenhouses, :school_id
	end
end
