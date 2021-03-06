class ConditionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def destroy?
    user.admin? || user.clinician?
  end

  def update_cut_offs?
    user.admin? || user.clinician?
  end

  def add_diagnosis_condition?
    destroy?
  end

  def destroy_diagnosis_condition?
    destroy?
  end

end
