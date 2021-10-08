class TwoFactorSettingsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin? || user.clinician? || user.deployment_manager? || user.medal_r_user?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def destroy?
    new?
  end
end
