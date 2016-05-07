class TestsController < ApplicationController
skip_before_filter  :verify_authenticity_token
	def index
		raise "get received"
	end

	def create 
		case params[:request_type]
			when 'get_value_types'
				f = Logger.new("log/http_request_supervision.log")
				f.info ""
				f.info "######## STARTING get_value_types ########"
				f.info ""

				@result = ValueType.all
				respond_to do |format|
					format.xml{render xml: @result}
				end		
				f.info "Answer sent"

			#Envoie à la serre les target value
			when "get_target_value"
				f = Logger.new("log/http_request_supervision.log")
				f.info ""
				f.info "######## Starting get_target_value  ########"
				greenhouse_id = Greenhouse.where(serial_nbr: params[:greenhouse_serial_nbr]).first.id
				@result = TargetValue.where("greenhouse_id = ? AND active = ?", greenhouse_id.to_i, true)

				respond_to do |format|
					format.xml{render xml: @result}
				end
				f.info "Answer sent"

			#Reçoit les nouvelles valeurs et les intègres à la bdd
			when "post_new_values"
				post_new_values
		end
			
	end

	private

	def post_new_values
		f = Logger.new("log/http_request_supervision.log")
		f.info ""
		f.info "######## Starting post_new_values ########"
		f.info ""
		f.info "getting all value_types"
		value_types = ValueType.all.collect(&:name)
		f.info "vt = #{value_types.join(', ')}"
		value_types.each do |v|
			f.info "#### processing #{v}"
			next if params[:"#{v}_value"].blank?

			value = params[:"#{v}_value"]
			created_at = Time.parse(params[:"#{v}_created_at"])
			data_card_id = DataCard.where(serial_nbr: params[:"#{v}_dc_serial_nbr"]).first.id
			value_type_id = ValueType.where(name: "#{v}").collect(&:id)[0].to_i
			
			new_value = Value.new

			new_value.value = value
			new_value.created_at = created_at
			new_value.data_card_id = data_card_id
			new_value.value_type_id = value_type_id

			if new_value.save 
				f.info "Value created : value = #{value} - value_type = #{v} - data_card_id = #{data_card_id} - created_at = #{created_at}"
				f.info "#{new_value.id}"
			else
				f.info "Error occured when adding value for #{v}"
			end
		end
		f.info ""
		f.info "END OF POST_NEW_VALUES PROCESS"
	end
end
