class HttpConnectionLog < ActiveRecord::Migration
  def up
		create_table :http_connection_logs do |t|
			t.string :connection_type
			t.integer :greenhouse_id

			t.timestamps
		end
  end

	def down
		drop_table :http_connection_logs
	end
end
