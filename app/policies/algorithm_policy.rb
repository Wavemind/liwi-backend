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
    index?
  end

  def new?
    user.admin? || user.clinician?
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

  def archive?
    new?
  end

  def unarchive?
    new?
  end

  def managements?
    index?
  end

  def drugs?
    index?
  end

  def questions?
    index?
  end

  def questions_sequences?
    index?
  end

  def questions_sequences_scored?
    index?
  end
end
