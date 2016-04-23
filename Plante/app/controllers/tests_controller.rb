class TestsController < ApplicationController
skip_before_filter  :verify_authenticity_token
	def index
		raise "get received"
	end

	def create 
		@result = TargetValue.where("greenhouse_id = ? AND active = ?", params[:greenhouse_id].to_i, true)
		respond_to do |format|
			format.xml{render xml: @result}
		end
	end
end
