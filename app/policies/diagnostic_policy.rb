class DiagnosticPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def has_study_access?
    record = @record.is_a?(ActiveRecord::Relation) ? @record.first : @record
    @user.studies.where(id: record.version.algorithm.study_id).any?
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def new?
    has_study_access? && (user.admin? || user.clinician?)
  end

  def show?
    has_study_access? && new?
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

  def destroy?
    has_study_access? && new?
  end

  def diagram?
    has_study_access? && index?
  end

  def duplicate?
    has_study_access? && new?
  end

  def validate?
    has_study_access? && new?
  end
end
