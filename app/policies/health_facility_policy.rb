class HealthFacilityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def has_study_access?
    @user.studies.where(id: @record.study_id).any?
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def show?
    has_study_access? && index?
  end

  def new?
    has_study_access? && (user.admin? || user.deployment_manager?)
  end

  def create?
    has_study_access? && new?
  end

  def edit?
    has_study_access? && new?
  end

  def update?
    has_study_access? && new?
  end

  def add_device?
    has_study_access? && new?
  end

  def remove_device?
    has_study_access? && new?
  end

  def sticker_form?
    has_study_access? && new?
  end

  def generate_stickers?
    has_study_access? && new?
  end
end
