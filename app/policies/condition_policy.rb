class ConditionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.admin? || user.clinician?
  end

  def add_diagnostic_condition?
    destroy?
  end

  def destroy_diagnostic_condition?
    destroy?
  end

end
