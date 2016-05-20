class PagesController < ApplicationController
	before_filter :verify_authorization, except: ["index"] 
	before_filter :get_datas, except: ["index"]
	
	def index
		if user_signed_in?
			if params[:ana_display] == "true"
			else
				if current_user.super_admin?
					redirect_to admin_schools_path
				else
					school_id = current_user.school.id
					redirect_to show_current_state_pages_path(id: school_id)
				end
			end
		else
			render "index"
			#respond_to do |format|
					#format.js {render inline: "location.reload();" }
			#end	
		end
	end

	def show_current_state 
		unless params[:selected_greenhouse].blank?
			@selected_greenhouse = Greenhouse.find(params[:selected_greenhouse])
		else
			@selected_greenhouse = Greenhouse.find(@greenhouses[0].id) unless @greenhouses.blank?
		end

		@value_types_header = ['Type de valeur','Valeur','Valeur cible']

		unless @selected_greenhouse.blank?
			@linked_data_cards = DataCard.where(greenhouse_id: @selected_greenhouse.id)
			@value_types.each do |g|
				instance_variable_set("@target_#{g.name}", TargetValue.where("greenhouse_id = ? AND value_type_id = ? AND active = ?", @selected_greenhouse.id, g.id, true)[0].value)
				instance_variable_set("@#{g.name}_values", Value.where("data_card_id in (?)", @linked_data_cards.collect(&:id)).select{|h| h.value_type_id == g.id}.sort{|b,c| b.created_at <=> c.created_at}.collect(&:value)[0])			
			end
		end
	end

	def show_parameters
		unless params[:selected_greenhouse].blank?
			@selected_greenhouse = Greenhouse.find(params[:selected_greenhouse])
		else
			@selected_greenhouse = Greenhouse.find(@greenhouses[0].id) unless @greenhouses.blank?
		end

		unless @selected_greenhouse.blank?
			@value_types.each do |g|
				target = TargetValue.where("greenhouse_id = ? AND value_type_id = ? AND active = ?", @selected_greenhouse.id, g.id, true)[0]
				unless target.blank?
					target_value = target.value
				else
					target_value = 'NA'
				end

				instance_variable_set("@target_#{g.name}", target_value) 
			end
		end
	end

	def update_parameters
		#On met la target value modifiée a false + deactivated at à Time.now
		#On crée une nouvelle valeur ensuite
		old_target = TargetValue.where("greenhouse_id = ? AND value_type_id = ? AND active = ?", params[:greenhouse_id], params[:value_type_id], true)[0]
		value_type = ValueType.find(params[:value_type_id])
		
		new_value = params[:"#{value_type.name}_value"] 

		begin
		ActiveRecord::Base.transaction do
			new_target = TargetValue.create(old_target.attributes.except("id"))
			new_target.update_attributes(value: new_value, created_at: Time.now, active: true, user_id: current_user.id)
			old_target.update_attributes(deactivated_at: new_target.created_at, active: false)
	  end

		flash[:notice] = 'Modification effectuée'
		redirect_to :back and return

		rescue
			flash[:notice] = "Erreur lors de la mise à jour"
			redirect_to :back and return
		end
	end

	def show_data
		unless params[:selected_greenhouse].blank?
			@selected_greenhouse = Greenhouse.find(params[:selected_greenhouse])
		else
			@selected_greenhouse = Greenhouse.find(@greenhouses[0].id) unless @greenhouses.blank?
		end

		unless @selected_greenhouse.blank?
			@linked_data_cards = DataCard.where(greenhouse_id: @selected_greenhouse.id)
			@hash_target_values = Hash.new
			@start_year = Value.maximum("created_at").year
			@end_year = Value.minimum("created_at").year
			@selected_date = String.new
			@display_div_months = "hidden"
			@display_div_days = "hidden"
			@days_in_month = 1
			@nb_months = 1
			condition = ["",""]
			condition[0] += "AND created_at BETWEEN ? AND ?"
			unless params[:year].blank?
				date = Time.mktime(params[:year].to_i)
				condition[1] = ["#{date}","#{date + 1.years}"]
				@selected_date = "#{params[:year]}"
				@display_div_months = ""
				@nb_months = 12
				unless params[:month].blank?
					date = Time.mktime(params[:year].to_i,params[:month].to_i)
					condition[1] = ["#{date}","#{date + 1.months}"]
					@days_in_month = (Time.days_in_month(params[:month].to_i, params[:year].to_i))
					@display_div_days = ""
					@selected_date = "#{FRENCH_MONTHS["#{date.month}"]} #{date.year}"
					unless params[:day].blank?
						date = Time.mktime(params[:year].to_i,params[:month].to_i,params[:day].split('!').map(&:to_i).sort[0].to_i)
						date2 = Time.mktime(params[:year].to_i,params[:month].to_i,params[:day].split('!').map(&:to_i).sort[-1].to_i) + 1.days - 1.seconds
						condition[1] = ["#{date}","#{date2}"]
						@selected_date = "#{date.day}-#{date2.day} #{FRENCH_MONTHS["#{date.month}"]} #{date.year}"
					end
				end
			else
				condition[1] = [["#{Time.mktime(Time.now.year)}"],["#{Time.mktime(Time.now.year) + 1.years}"]] 
				@selected_date = "#{Time.now.year}"
			end

			@value_types.each do |g|
				max_deactivated_at = TargetValue.where('greenhouse_id = ? AND value_type_id = ?',@selected_greenhouse.id,g.id).order('deactivated_at DESC').first.deactivated_at
				all_values = Value.where("data_card_id in (?) AND value_type_id = ? #{condition[0]}", @linked_data_cards.collect(&:id),g.id, condition[1][0], condition[1][1])
				
				all_values.each do |y|
					target = TargetValue.where('greenhouse_id = ? AND value_type_id = ? AND created_at < ? AND deactivated_at > ?', @selected_greenhouse.id,g.id,y.created_at,y.created_at).first
					target ||= TargetValue.where('greenhouse_id = ? AND value_type_id = ? AND active = ?',@selected_greenhouse.id,g.id,true).first
					@hash_target_values[:"id#{y.id}"] = target.value
				end
				instance_variable_set("@#{g.name}_values", all_values)
			end	
		end
	end

	def show_media_file
		@media_file_types = MediaFileType.all
		if params[:search_type].blank? || params[:search_type] == "all"
			@media_files = MediaFile.where('to_show = ?',true).select{|v| v.school.collect(&:id).include?(params[:id].to_i)}.sort{|a,b| a.attachement.to_s.split('/')[-1] <=> b.attachement.to_s.split('/')[-1]}
		end

		@media_file_types.each do |v|
			if params[:search_type] == v.name  
				@media_files = MediaFile.where("media_file_type_id = ? AND to_show = ?", v.id, true).select{|v| v.school.collect(&:id).include?(params[:id].to_i)}.sort{|a,b| a.attachement.to_s.split('/')[-1] <=> b.attachement.to_s.split('/')[-1]}
				break
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

	def get_datas
		@greenhouses = Greenhouse.where("ID in (?)", School.find(params[:id]).greenhouse.collect(&:id))
		@value_types = ValueType.all
	end
end
