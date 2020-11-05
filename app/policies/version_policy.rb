class VersionPolicy < ApplicationPolicy
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

  def change_triage_order?
    true
  end

  def components?
    new?
  end

  def remove_components?
    new?
  end

  def create_triage_condition?
    new?
  end

  def duplicate?
    new?
  end

  def final_diagnostics?
    index?
  end

  def final_diagnoses_exclusions?
    index?
  end

  def generate_translations?
    new?
  end

  def generate_variables?
    new?
  end

  def import_translations?
    new?
  end

  def regenerate_json?
    index?
  end

  def remove_triage_condition?
    new?
  end

  def update_list?
    new?
  end
end
