class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def operators?
    user.admin? || user.clinician?
  end
end
