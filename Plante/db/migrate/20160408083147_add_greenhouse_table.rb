class AddGreenhouseTable < ActiveRecord::Migration
  def up
		create_table :greenhouses do |t|
			t.string :name
			t.text :description
			t.timestamps
		end
  end

	def down
		remove_table :greenhouses
	end
end
