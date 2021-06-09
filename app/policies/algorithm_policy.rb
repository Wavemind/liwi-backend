class AlgorithmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def has_study_access?
    @user.studies.where(id: @record.study_id).any?
  end

  def index?
    user.admin? || user.clinician? || user.deployment_manager?
  end

  def show?
    has_study_access? && index?
  end

  def new?
    user.admin? || user.clinician?
  end

  def create?
    new?
  end

  def edit?
    has_study_access? && new?
  end

  def update?
    has_study_access? && new?
  end

  def archive?
    has_study_access? && new?
  end

  def unarchive?
    has_study_access? && new?
  end

  def managements?
    has_study_access? && index?
  end

  def drugs?
    has_study_access? && index?
  end

  def questions?
    has_study_access? && index?
  end

  def questions_sequences?
    has_study_access? && index?
  end

  def questions_sequences_scored?
    has_study_access? && index?
  end

  def drug_exclusions?
    has_study_access? && index?
  end

  def management_exclusions?
    has_study_access? && index?
  end

  def import_villages?
    has_study_access? && new?
  end
end
