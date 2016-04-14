class AddNewFields < ActiveRecord::Migration
  def up
		add_column :greenhouses, :serial_nbr, :text
  end
	
	def down
		remove_column :greenhouses, :serial_nbr
	end
end
