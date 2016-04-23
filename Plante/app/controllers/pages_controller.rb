class PagesController < ApplicationController
	before_filter :get_datas
	
	def index
		puts "hello"
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
		end
	end

	def show_current_state 
		unless params[:selected_greenhouse].blank?
			@selected_greenhouse = Greenhouse.find(params[:selected_greenhouse])
		else
			@selected_greenhouse = Greenhouse.find(@greenhouses[0].id) unless @greenhouses.blank?
		end

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
			@value_types.each do |g|
				max_deactivated_at = TargetValue.where('greenhouse_id = ? AND value_type_id = ?',@selected_greenhouse.id,g.id).order('deactivated_at DESC').first.deactivated_at
				all_values = Value.where("data_card_id in (?) AND value_type_id = ?", @linked_data_cards.collect(&:id),g.id)
				
				all_values.each do |y|
					target = TargetValue.where('greenhouse_id = ? AND value_type_id = ? AND created_at < ? AND deactivated_at > ?', @selected_greenhouse.id,g.id,y.created_at,y.created_at).first
					target ||= TargetValue.where('greenhouse_id = ? AND value_type_id = ? AND active = ?',@selected_greenhouse.id,g.id,true).first
					@hash_target_values[:"id#{y.id}"] = target.value
				end
				instance_variable_set("@#{g.name}_values", all_values)
			end	
		end
	end

	private

	def get_datas
		@greenhouses = Greenhouse.where(school_id: params[:id])
		@value_types = ValueType.all
	end
end
