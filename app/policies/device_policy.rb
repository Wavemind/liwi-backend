class DevicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user.admin? || user.clinician?
  end

  def show?
    user.admin? || user.clinician?
  end
end
