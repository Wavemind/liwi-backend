class DrugPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin? || user.clinician?
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def create_exclusion?
    new?
  end

  def remove_exclusion?
    new?
  end

  def lists?
    user.admin? || user.clinician? || user.deployment_manager?
  end

  def validate?
    new?
  end
end
