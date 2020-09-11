class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || user.clinician? || user.deployment_manager?
  end

  def show?
    index?
  end

  def activated?
    user.admin?
  end

  def deactivated?
    user.admin?
  end
end
