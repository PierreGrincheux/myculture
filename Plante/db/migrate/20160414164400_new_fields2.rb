class NewFields2 < ActiveRecord::Migration
  def up
		add_column :target_values, :deactivated_at, :datetime
  end

	def down
		remove_column :target_values, :deactivated_at
	end
end
