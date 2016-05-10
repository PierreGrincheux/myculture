class Teacher::MediaFileHandlersController < ApplicationController
  def index
		@media_files = MediaFile.all
  end

  def new
		@media_file = MediaFile.new
  end

  def create
		media_file = MediaFile.new(media_file_params)


		if media_file.save
			redirect_to teacher_media_file_handlers_path, notice: "Ajout effectué"
		else
			render "new"
		end
  end

  def destroy
		media_file = MediaFile.find(params[:id])
		media_file.destroy
		redirect_to teacher_media_file_handlers_path, notice: "Suppression effectuée"
  end

	private

	def media_file_params
		params.require(:media_file).permit(:title, :description, :attachement)
	end
end
