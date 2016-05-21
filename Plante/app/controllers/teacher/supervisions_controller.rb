class Teacher::SupervisionsController < ApplicationController
	before_filter :verify_authorization

	def index
		all_operations = HTTP_CONNECTION_TYPES.keys
		@all_families = HTTP_CONNECTION_TYPES.values.collect{|g| g[1]}.uniq
		@all_greenhouses = Greenhouse.where("school_id = ?", params[:id])
		
		##### VALUE TYPES
		value_types = ValueType.all
		@all_value_types = Hash.new
		value_types.each do |v|
			@all_value_types[:"#{v.id}"] = v.name
		end
		
		
		##### HTTP LOGS
		@logs = Hash.new
		@all_greenhouses.each do |t|
			@logs[:"#{t.serial_nbr}"] = Hash.new
			all_operations.each do |v|
				log = HttpConnectionLog.where("connection_type = ? AND greenhouse_id = ?", v.to_s, t.id)
	
				unless log.blank?
					log = log.reverse.first.created_at.localtime.strftime("%d/%m/%Y %H:%M:%S")
					@logs[:"#{t.serial_nbr}"].merge!({"#{v}": log})
				else
					@logs[:"#{t.serial_nbr}"].merge!({"#{v}": ""})
				end
			end
		end
		##### TARGET VALUES
		@all_target_values = Array.new
		req = TargetValue.where("greenhouse_id IN (?) AND active = ?", @all_greenhouses.collect(&:id), true)
		req.each do |k|
			@all_target_values << [k.value_type_id,k.value]
		end
	end

private

	def verify_authorization
		if current_user.super_admin?
			return true
		end

		if current_user.school.id != params[:id] || !current_user.teacher?
			raise
		end
	end

end
