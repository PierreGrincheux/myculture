class TestsController < ApplicationController
skip_before_filter  :verify_authenticity_token
	def index
		raise "get received"
	end

	def create 
		f = Logger.new("log/http_request_supervision.log")
		case params[:request_type]
			when 'get_value_types'
				
				f.info ""
				f.info "######## STARTING get_value_types ########"
				f.info ""

				greenhouse_id = Greenhouse.where(serial_nbr: params[:greenhouse_serial_nbr]).first.id
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
				greenhouse_id = Greenhouse.where(serial_nbr: params[:greenhouse_serial_nbr]).first.id
				post_new_values

			when "post_pictures"
				f = Logger.new("log/http_request_supervision.log")
				f.info ""
				f.info "######## Starting post_pictures  ########"
				f.info "gnagnagna"
				f.info "#{params}"		
				greenhouse_id = Greenhouse.where(serial_nbr: params[:greenhouse_serial_nbr]).first.id

				f.info "gnagnagna"
				params[:request_type] = "#{params[:request_type]}_#{params[:state]}"
				f.info "params[:request_type] = #{params[:request_type]}"
				f.info "params[:upload] = #{params[:upload].tempfile.path}"
				f.info "moving image to /app/assets/images/greehouses_pictures/#{params[:greenhouse_serial_nbr]} with name = #{params[:upload].original_filename}"
				Dir.mkdir("#{Rails.root}/app/assets/images/greenhouses_pictures/#{params[:greenhouse_serial_nbr]}") unless File.directory?("#{Rails.root}/app/assets/images/greenhouses_pictures/#{params[:greenhouse_serial_nbr]}")
				File.rename("#{params[:upload].tempfile.path}","#{Rails.root}/app/assets/images/greenhouses_pictures/#{params[:greenhouse_serial_nbr]}/#{params[:upload].original_filename}")

				mft_id = MediaFileType.where(name: 'timelapse_photo').first.id
				f.info "MFT_ID = #{mft_id}"
				date = params[:upload].original_filename.split('_')[0]
				f.info "date = #{date}"
				creation_date = Time.mktime(date[0..3].to_i,date[4..5].to_i,date[6..7].to_i,date[8..9],date[10..11],date[12..13],date[14..15])
				f.info "creation_date = #{creation_date}"

				mf = MediaFile.new(
							media_file_type_id: mft_id,
							to_show: true,
							path: "greenhouses_pictures/#{params[:greenhouse_serial_nbr]}/#{params[:upload].original_filename}",
							created_at: creation_date,
							title: "Photo du #{creation_date.strftime("%d/%m/%Y")}",
							greenhouse_id: greenhouse_id				
				)

				if mf.save
					f.info "MF_PHOTO created"
				else
					f.info "ERROR WITH MF_PHOTO CREATION"
				end
		end

		f.info "out"
		f.info "#{params[:request_type]}"
		log = HttpConnectionLog.new
		log.connection_type = params[:request_type]
		log.greenhouse_id = greenhouse_id
		log.save
			
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
