class Admin::GreenhousesController < ApplicationController
	layout "admin"

	def index
		@all_greenhouses = Greenhouse.all
	end

	def new
		@greenhouse = Greenhouse.new
	end

	def create
		@greenhouse = Greenhouse.new(greenhouse_params)
		if @greenhouse.save
			flash[:notice] = "Nouvelle serre ajoutée"
			redirect_to admin_greenhouse_path(@greenhouse)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@greenhouse = Greenhouse.where(id: params[:id])[0]
	end

	def update
		@greenhouse = Greenhouse.where(id: params[:id].to_i)[0]
		if @greenhouse.update_attributes(greenhouse_params)
			flash[:notice] = "Mise à jour effectuée"
			redirect_to admin_greenhouse_path(@greenhouse)
		else
			flash[:notice] = "Erreur lors de la mis à jour"
			render "edit"
		end
	end

	def destroy
		@greenhouse = Greenhouse.where(id: params[:id])[0]
		if @greenhouse.destroy
			flash[:notice] = "Serre supprimée"
			redirect_to admin_greenhouses_path
		else
			flash[:notice] = "Erreur lors de la suppression"
			redirect_to admin_greenhouses_path
		end
	end

	def show
		@greenhouse = Greenhouse.where(id: params[:id].to_i)[0]	
	end

	private

	def greenhouse_params
		params.require(:greenhouse).permit(:serial_nbr)
	end

end
