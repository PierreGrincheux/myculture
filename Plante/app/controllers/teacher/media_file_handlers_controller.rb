class Teacher::MediaFileHandlersController < ApplicationController
  def index
		@media_file_types = MediaFileType.all
		if params[:search_type].blank? || params[:search_type] == "all"
			@media_files = MediaFile.all.select{|v| v.school.collect(&:id).include?(params[:id].to_i)}.sort{|a,b| a.attachement.to_s.split('/')[-1] <=> b.attachement.to_s.split('/')[-1]}
		end

		@media_file_types.each do |v|
			if params[:search_type] == v.name  
				@media_files = MediaFile.where("media_file_type_id = ?", v.id).select{|v| v.school.collect(&:id).include?(params[:id].to_i)}.sort{|a,b| a.attachement.to_s.split('/')[-1] <=> b.attachement.to_s.split('/')[-1]}
				break
			end
		end
  end

  def new
		@media_file = MediaFile.new
  end

  def create
		media_file = MediaFile.new(media_file_params)
		school = School.find(params[:school_id])
		media_file.school << school

		if media_file.save
			redirect_to teacher_media_file_handlers_path(id: params[:school_id]), notice: "Ajout effectué"
		else
			render "new"
		end
  end

	def edit
		@media_file = MediaFile.find(params[:id])
	end

	def update
		media_file = MediaFile.find(params[:id])
		if media_file.update_attributes(media_file_params)
			redirect_to teacher_media_file_handlers_path(id: params[:school_id]), notice: "Mise à jour effectuée"
		else
			render 'edit'
		end
	end

  def destroy
		media_file = MediaFile.find(params[:id])
		media_file.destroy
		redirect_to teacher_media_file_handlers_path(id: params[:school_id]), notice: "Suppression effectuée"
  end

	private

	def media_file_params
		params.require(:media_file).permit(:title, :description, :attachement, :to_show, :media_file_type_id)
	end
end
