class PagesController < ApplicationController
	before_filter :get_datas
	
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
				instance_variable_set("@target_#{g.name}", TargetValue.where("greenhouse_id = ? AND value_type_id = ?", @selected_greenhouse.id, g.id)[0].value)
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
				target = TargetValue.where("greenhouse_id = ? AND value_type_id = ?", @selected_greenhouse.id, g.id)[0]
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
		target = TargetValue.where("greenhouse_id = ? AND value_type_id = ?", params[:greenhouse_id], params[:value_type_id])[0]
		value_type = ValueType.find(params[:value_type_id])
		new_value = params[:"#{value_type.name}_value"] 
		if target.update_attributes(value: new_value)
			 flash[:notice] = "Modification effectuée"
			 redirect_to show_parameters_pages_path(id: params[:school_id], selected_greenhouse: params[:greenhouse_id])
		else
			 flash[:notice] = "Erreur lors de la modification"
			 redirect_to :back
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
			@value_types.each do |g|
				instance_variable_set("@#{g.name}_values", Value.where("data_card_id in (?)", @linked_data_cards.collect(&:id)).select{|h| h.value_type_id == g.id}).sort{|b,c| b.created_at <=> c.created_at}
			end	
		end
	end

	private

	def get_datas
		@greenhouses = Greenhouse.where(school_id: params[:id])
		@value_types = ValueType.all
	end
end
