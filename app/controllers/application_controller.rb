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

  def set_algorithm_version
    @algorithm_version = AlgorithmVersion.find(params[:algorithm_version_id])
  end

  def set_relation
    @relation = Relation.find(params[:relation_id])
  end
end
