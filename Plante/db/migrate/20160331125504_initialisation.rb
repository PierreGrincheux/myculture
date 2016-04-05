class Initialisation < ActiveRecord::Migration
  def up
  	create_table :control_cards do |t|
  		t.text :serial_nbr
  	end

  	create_table :data_cards do |t|
  		t.text :serial_nbr
  	end

  	create_table :values do |t|
  		t.float :value
  	end

  	create_table :value_types do |t|
  		t.text :name
  	end

  	create_table :target_values do |t|
  		t.float :value
  		t.boolean :active
  	end

  	create_table :users do |t|
  		t.text :login
  		t.text :password
  	end

  	create_table :media_files do |t|
  		t.text :title
  		t.text :description
  		t.text :path
  	end

  	create_table :schools do |t|
  		t.text :name
  		t.text :adress
  		t.text :zip_code
  		t.text :town
  		t.text :phone_number
  		t.text :email
  		t.text :contact
  		t.text :description
  	end

  end

  def down

  	drop_table :control_cards

  	drop_table :data_cards

  	drop_table :values

  	drop_table :value_types

  	drop_table :target_values

  	drop_table :users

  	drop_table :media_files

  	drop_table :schools


  end
end
