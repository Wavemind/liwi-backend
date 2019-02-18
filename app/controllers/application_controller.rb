class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  layout :layout_by_resource

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

  def set_version
    @version = Version.find(params[:version_id])
  end

  def set_instance
    @instance = Instance.find(params[:instance_id])
  end
end
