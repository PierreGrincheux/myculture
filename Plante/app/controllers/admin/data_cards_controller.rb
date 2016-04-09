class Admin::DataCardsController < ApplicationController
	layout "admin"

	def index
		@all_data_cards = DataCard.all
	end

	def new
		@data_card = DataCard.new
		@linkable_control_cards = ControlCard.all
	end

	def create
		@data_card = DataCard.new(data_card_params)
		if @data_card.save
			flash[:notice] = "Nouvelle carte de contrôle secondaire ajoutée"
			redirect_to admin_data_card_path(@data_card)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@data_card = DataCard.where(id: params[:id])[0]
		@linkable_control_cards = ControlCard.all
		@blank_included = false || true if !@data_card.control_card.blank?
	end

	def update
		@data_card = DataCard.where(id: params[:id].to_i)[0]
		if @data_card.update_attributes(data_card_params)
			flash[:notice] = "Mise à jour effectuée"
			redirect_to admin_data_card_path(@data_card)
		else
			flash[:notice] = "Erreur lors de la mis à jour"
			render "edit"
		end
	end

	def destroy
		@data_card = DataCard.where(id: params[:id])[0]
		if @data_card.destroy
			flash[:notice] = "Carte de contrôle secondaire supprimée"
			redirect_to admin_data_cards_path
		else
			flash[:notice] = "Erreur lors de la suppression"
			redirect_to admin_data_cards_path
		end
	end

	def show
		@data_card = DataCard.where(id: params[:id].to_i)[0]	
	end

	private

	def data_card_params
		params.require(:data_card).permit(:serial_nbr, :control_card_id)
	end
end
