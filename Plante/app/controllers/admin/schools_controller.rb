class Admin::SchoolsController < ApplicationController
	def index
		@all_schools = School.all
	end

	def new
		@school = School.new
	end

	def create
		@school = School.new(school_params)
		if @school.save
			flash[:notice] = "Nouvelle école ajoutée"
			redirect_to admin_school_path(@school)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@school = School.where(id: params[:id])[0]
	end

	def update
		@school = School.where(id: params[:id].to_i)[0]
		if @school.update_attributes(school_params)
			flash[:notice] = "Mise à jour effectuée"
			redirect_to admin_school_path(@school)
		else
			flash[:notice] = "Erreur lors de la mis à jour"
			render "edit"
		end
	end

	def destroy
		@school = School.where(id: params[:id])[0]
		if @school.destroy
			flash[:notice] = "École supprimée"
			redirect_to admin_schools_path
		else
			flash[:notice] = "Erreur lors de la suppression"
			redirect_to admin_scholls_path
		end
	end

	def show
	
	end

	private

	def school_params
		params.require(:school).permit(:name, :adress, :town, :zipcode, :contact, :phone_number, :email)
	end
end
