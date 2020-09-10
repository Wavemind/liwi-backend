class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def activated?
    user.admin?
  end

  def deactivated?
    user.admin?
  end
end
