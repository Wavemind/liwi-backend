class AlgorithmPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
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
    show?
  end

  def update?
    show?
  end

  def archive?
    show?
  end

  def unarchive?
    show?
  end

  def managements?
    show?
  end

  def drugs?
    show?
  end

  def questions?
    show?
  end

  def questions_sequences?
    show?
  end

  def questions_sequences_scored?
    show?
  end

  def drug_exclusions?
    show?
  end

  def management_exclusions?
    show?
  end

  def import_villages?
    show?
  end

  private

  def has_study_access?
    @user.studies.where(id: @record.study_id).any?
  end
end
