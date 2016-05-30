class Admin::GreenhousesController < ApplicationController
	layout "admin"

	def index
		@all_greenhouses = Greenhouse.all
	end

	def new
		@greenhouse = Greenhouse.new
		@linkable_schools = School.all
	end

	def create
		greenhouse = Greenhouse.new(greenhouse_params)
		if greenhouse.save
			ValueType.all.each do |v|
				TargetValue.create(greenhouse_id: greenhouse.id, value_type_id: v.id)
			end
			flash[:notice] = "Nouvelle serre ajoutée"
			redirect_to admin_greenhouse_path(greenhouse)
		else
			flash[:notice] = "Erreur lors de l'enregistrement"
			render "new"
		end
	end

	def edit
		@greenhouse = Greenhouse.where(id: params[:id])[0]
		@linkable_schools = School.all
		unless @greenhouse.school.blank?
			@blank_included = true
		end
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
		all_operations = HTTP_CONNECTION_TYPES.keys
		@all_families = HTTP_CONNECTION_TYPES.values.collect{|g| g[1]}.uniq
		@logs = Hash.new
		all_operations.each do |v|
			log = HttpConnectionLog.where("connection_type = ? and greenhouse_id = ?", v.to_s, @greenhouse.id)
			unless log.blank?
				log = log.reverse.first.created_at.localtime.strftime("%d/%m/%Y %H:%M:%S")
				@logs[:"#{v}"] = log
			else
				@logs[:"#{v}"] = ""
			end
	  end
	end

	private

	def greenhouse_params
		params.require(:greenhouse).permit(:serial_nbr, :school_id, :name)
	end

end
