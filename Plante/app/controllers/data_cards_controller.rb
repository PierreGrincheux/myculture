class DataCardsController < ApplicationController
	layout "admin"

	def index
		@all_data_cards = DataCard.all
	end

	def new
		@data_card = DataCard.new
	end

	def create
		@data_card = DataCard.new(control_card_params)
		if @data_card.save
			flash[:notice] = "Nouvelle école ajoutée"
			redirect_to admin_data_card_path(@data_card)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@data_card = DataCard.where(id: params[:id])[0]
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
			flash[:notice] = "Carte de contrôle supprimée"
			redirect_to admin_data_cards_path
		else
			flash[:notice] = "Erreur lors de la suppression"
			redirect_to admin_data_cards_path
		end
	end

	def show
		@data_card = DataCard.where(id: params[:id].to_i)[0]	
	end
end
