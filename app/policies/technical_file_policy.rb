class TechnicalFilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || user.clinician? || user.deployment_manager? || user.medal_r_user?
  end

end
