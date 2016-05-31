class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_filter :update_locale

  protect_from_forgery with: :exception

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :first_name
		devise_parameter_sanitizer.for(:account_update) << :first_name

		devise_parameter_sanitizer.for(:sign_up) << :last_name
		devise_parameter_sanitizer.for(:account_update) << :last_name
	end

	private
	def update_locale 
		unless params[:locale].blank?
			I18n.locale = params[:locale] 
		end
	end


end
