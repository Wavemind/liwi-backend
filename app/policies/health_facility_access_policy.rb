class HealthFacilityAccessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || user.deployment_manager?
  end

  def create?
    index?
  end
end
