class FinalDiagnosticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || user.clinician? || user.deployment_manager?
  end

  def new?
    user.admin? || user.clinician?
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

  def destroy?
    new?
  end

  def add_exclusion?
    new?
  end

  def diagram?
    index?
  end

  def remove_exclusion?
    new?
  end

  def update_translations?
    new?
  end

end
