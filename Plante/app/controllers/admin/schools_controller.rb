class Admin::SchoolsController < ApplicationController
	def index
		@all_schools = School.all
	end

	def new
		@school = School.new
	end

	def create

	end

	def edit
		@school = School.where(id: params[:id])[0]
	end

	def update

	end

	def destroy
		redirect_to '/admin/schools/index', :notice => "Passed by destroy with id = #{params[:id]}"
	end

	def show
	
	end
end
