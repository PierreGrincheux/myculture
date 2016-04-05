class SchoolsController < ApplicationController
	def index
		@result= School.all;
	end
end
