class Api::V1::ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def is_available
    render json: 'true'
  end

  def categories
    render json: Question.categories('Diagnosis').as_json
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
