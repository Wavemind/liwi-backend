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
end
