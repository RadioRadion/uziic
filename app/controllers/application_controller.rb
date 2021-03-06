class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:pseudo])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:pseudo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:pseudo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:address])
  end

  def default_url_options

  { host: ENV["www.uziic.com"] || "localhost:3000" }
  end
end
