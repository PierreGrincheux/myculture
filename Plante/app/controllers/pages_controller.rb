class PagesController < ApplicationController
	def index
		if user_signed_in?
			if params[:ana_display] == "true"
			else
				if current_user.super_admin?
					redirect_to admin_schools_path
				else
								raise 'tiiti'
					school_id = current_user.school.id
					redirect_to show_current_state_pages_path(id: school_id)
				end
			end
		end
	end

	def show_current_state 
		@greenhouses = Greenhouse.where(school_id: params[:id])
		unless params[:selected_greenhouse].blank?
			@selected_greenhouse = Greenhouse.find(params[:selected_greenhouse])
		else
			@selected_greenhouse = Greenhouse.find(@greenhouses[0].id) unless @greenhouses.blank?
		end

		unless @selected_greenhouse.blank?
			@linked_data_cards = DataCard.where(greenhouse_id: @selected_greenhouse.id)
			@all_value_types = ValueType.all
			
			@all_values = Value.where("data_card_id IN (?)", @linked_data_cards.collect(&:id))
		end
	end

	def show_target_values
					
	end

	def show_data

	end
end
