class Api::V1::ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  #
  # rescue_from ActionController::RoutingError do |exception|
  #   render json: {errors: 'Path not found'}, status: 404
  # end
  #
  # def catch_404
  #   raise ActionController::RoutingError.new(params[:path])
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

end
