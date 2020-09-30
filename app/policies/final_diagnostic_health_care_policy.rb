class FinalDiagnosticHealthCarePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin? || user.clinician?
  end

  def destroy?
    create?
  end
end
