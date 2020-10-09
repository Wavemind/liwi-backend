class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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

  def lists?
    user.admin? || user.clinician? || user.deployment_manager?
  end

  def reference_prefix?
    lists?
  end

  def validate?
    new?
  end
end
