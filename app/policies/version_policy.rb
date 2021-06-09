class VersionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def has_study_access?
    @user.studies.where(id: @record.algorithm.study_id).any?
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def show?
    has_study_access? && index?
  end

  def new?
    has_study_access? && (user.admin? || user.clinician?)
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

  def archive?
    has_study_access? && new?
  end

  def unarchive?
    has_study_access? && new?
  end

  def change_triage_order?
    has_study_access?
  end

  def change_systems_order?
    has_study_access?
  end

  def set_medal_data_config?
    has_study_access?
  end

  def update_full_order?
    has_study_access?
  end

  def components?
    has_study_access?
  end

  def remove_components?
    has_study_access?
  end

  def create_triage_condition?
    has_study_access?
  end

  def duplicate?
    has_study_access?
  end

  def final_diagnostics?
    has_study_access?
  end

  def final_diagnoses_exclusions?
    has_study_access?
  end

  def generate_translations?
    has_study_access?
  end

  def generate_variables?
    has_study_access?
  end

  def import_translations?
    has_study_access?
  end

  def regenerate_json?
    has_study_access?
  end

  def remove_triage_condition?
    has_study_access?
  end

  def update_list?
    has_study_access?
  end

  def job_status?
    has_study_access?
  end
end
