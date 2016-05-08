class Teacher::SupervisionsController < ApplicationController
	before_filter :verify_authorization

	def index
		all_operations = HTTP_CONNECTION_TYPES.keys
		all_greenhouses = Greenhouse.where("school_id = ?", params[:id])
		@logs = Hash.new
		all_operations.each do |v|
			@logs[:"#{v}"] = Array.new
			all_greenhouses.each do |t|
				@logs[:"#{v}"] << [t.serial_nbr, HttpConnectionLog.where("connection_type = ? AND greenhouse_id = ?", v.to_s, t.id).reverse.first.created_at.localtime.strftime("%d/%m/%Y %H:%M:%S")]
			end
		end
	end

private

	def verify_authorization
		if current_user.super_admin?
			return true
		end

		if current_user.school.id != params[:id]
			raise
		end
	end

end
