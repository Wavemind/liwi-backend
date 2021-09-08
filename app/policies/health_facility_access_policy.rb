class HealthFacilityAccessPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def has_study_access?
    @user.studies.where(id: @record.health_facility.study_id).any?
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def create?
    has_study_access? && index?
  end
end
