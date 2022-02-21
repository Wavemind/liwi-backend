class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  layout :layout_by_resource
  before_action :set_home_breadcrumb
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :set_study_language
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Callback if user is not authorized to a specific resources
  def user_not_authorized
    flash[:alert] = t('access_denied')
    redirect_back fallback_location: root_url
  end

  private

  def layout_by_resource
    if user_signed_in?
      'application'
    else
      'login'
    end
  end

  def set_algorithm
    @algorithm = Algorithm.find(params[:algorithm_id])
  end

  def set_current_user
    User.set_current(current_user, request.ip)
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end

  def set_home_breadcrumb
    add_breadcrumb t('breadcrumbs.home'), root_url
  end

  def set_version
    @version = Version.find(params[:version_id])
  end

  # Set an instance variable so we can retrieve the current study language whenever we are in an algorithm level or below
  def set_study_language
    if params[:algorithm_id].present?
      @default_language = Algorithm.find(params[:algorithm_id]).study.default_language
    elsif controller_name == 'algorithms' && params[:id].present?
      @default_language = Algorithm.find(params[:id]).study.default_language
    elsif controller_name == 'questions_sequences'
      @default_language = QuestionsSequence.find(params[:id]).algorithm.study.default_language
    end
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|^(settings$)|^(api\/v1\/)|^(two_factor_settings$)/
  end

  # Whitelists additional parameters for Devise Controllers (default: email, password)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
        :first_name,
        :last_name,
        :email,
    ])
  end

end
