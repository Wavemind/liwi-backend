class QuestionsSequencePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.admin? || user.clinician?
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def diagram?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def lists?
    diagram?
  end

  def reference_prefix?
    diagram?
  end

  def validate?
    new?
  end

  private

  def has_study_access?
    @user.studies.where(id: @record.algorithm.study_id).any?
  end
end
