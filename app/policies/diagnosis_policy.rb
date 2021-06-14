class DiagnosisPolicy < ApplicationPolicy
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

  def show?
    new?
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

  def diagram?
    index?
  end

  def duplicate?
    new?
  end

  def validate?
    new?
  end
end
