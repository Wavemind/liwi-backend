class HealthFacilityPolicy < ApplicationPolicy
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

  def new?
    user.admin? || user.deployment_manager?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def add_device?
    new?
  end

  def remove_device?
    new?
  end
end
