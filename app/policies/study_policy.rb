class StudyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    has_study_access? && (user.admin? || user.clinician?)
  end

  def update?
    edit?
  end

  private

  def has_study_access?
    @user.studies.where(id: @record.id).any?
  end
end
