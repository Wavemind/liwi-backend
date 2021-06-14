class DiagnosisPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def new?
    has_study_access? && (user.admin? || user.clinician?)
  end

  def show?
    new?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def diagram?
    new?
  end

  def duplicate?
    new?
  end

  def validate?
    new?
  end

  private

  def has_study_access?
    record = @record.is_a?(ActiveRecord::Relation) ? @record.first : @record
    @user.studies.where(id: record.version.algorithm.study_id).any?
  end
end
