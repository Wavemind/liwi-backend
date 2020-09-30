class ManagementPolicy < ApplicationPolicy
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

  def validate?
    new?
  end

  def create_exclusion?
    new?
  end

  def remove_exclusion?
    new?
  end
end
