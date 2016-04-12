class PagesController < ApplicationController
	before_filter :verify_if_teacher, :only => :show_parameters
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
			
			@all_values = Value.where("data_card_id IN (?)", @linked_data_cards.collect(&:id))
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

	def show_data

	end

	private

	def verify_if_teacher
		unless current_user.teacher?
			flash[:alert] = "Vous n'avez pas les droits pour accéder à cette page."
			redirect_to show_current_state_pages_path(id: params[:id])
		else
			flash[:alert] = "Accès autorisé"
		end
	end

	def get_datas
		@greenhouses = Greenhouse.where(school_id: params[:id])
		@value_types = ValueType.all
	end
end
