class PagesController < ApplicationController
	def index
		if user_signed_in?
			if params[:all_displays] = true
				
			else
				if current_user.super_admin?
					redirect_to admin_schools_path
				else
					school_id = current_user.school.id
					redirect_to page_path(school_id)
				end
			end
		end
	end

	def show 
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
			@all_targeted_values = TargetValue.where(greenhouse_id: @selected_greenhouse.id)
		end
	end

end
