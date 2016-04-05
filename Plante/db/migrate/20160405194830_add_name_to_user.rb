class AddNameToUser < ActiveRecord::Migration
  def up
		add_column :users, :first_name, :string
		add_column :users, :last_name, :string
		add_column :users, :teacher, :boolean, default: false
		add_column :users, :super_admin, :boolean, default: false
  end

	def down
		remove_column :users, :first_name
		remove_column :users, :last_name
		remove_column :users, :teacher
		remove_column :users, :super_admin
	end
end
