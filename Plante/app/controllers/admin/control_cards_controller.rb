class Admin::ControlCardsController < ApplicationController
	layout "admin"

	def index
		@all_control_cards = ControlCard.all
	end

	def new
		@control_card = ControlCard.new
		@linkable_schools = School.all.select{|y| y.control_card.blank? == true}
	end

	def create
		@control_card = ControlCard.new(control_card_params)
		if @control_card.save
			flash[:notice] = "Nouvelle carte de contrôle ajoutée"
			redirect_to admin_control_card_path(@control_card)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@control_card = ControlCard.where(id: params[:id])[0]
		@linkable_schools = School.all.select{|y| y.control_card.blank? == true}
		unless @control_card.school.blank?
			@linkable_schools << @control_card.school
		end
	end

	def update
		@control_card = ControlCard.where(id: params[:id].to_i)[0]
		if @control_card.update_attributes(control_card_params)
			flash[:notice] = "Mise à jour effectuée"
			redirect_to admin_control_card_path(@control_card)
		else
			flash[:notice] = "Erreur lors de la mis à jour"
			render "edit"
		end
	end

	def destroy
		@control_card = ControlCard.where(id: params[:id])[0]
		if @control_card.destroy
			flash[:notice] = "Carte de contrôle supprimée"
			redirect_to admin_control_cards_path
		else
			flash[:notice] = "Erreur lors de la suppression"
			redirect_to admin_control_cards_path
		end
	end

	def show
		@control_card = ControlCard.where(id: params[:id].to_i)[0]	
		unless @control_card.school.blank?
			@linked_school = School.where(id: @control_card.school.id)[0]
		end
	end

	private

	def control_card_params
		params.require(:control_card).permit(:serial_nbr, :school_id)
	end

end
