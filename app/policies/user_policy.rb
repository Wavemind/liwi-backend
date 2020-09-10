class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  # TODO: Rajouter le clinician pour index et show

  def index?
    user.admin? || user.clinician?
  end

  def show?
    user.admin? || user.clinician?
  end

  def activated?
    user.admin?
  end

  def deactivated?
    user.admin?
  end
end
