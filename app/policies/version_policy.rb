class VersionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    has_study_access? && (user.admin? || user.clinician? || user.deployment_manager?)
  end

  def show?
    index?
  end

  def new?
    has_study_access? && (user.admin? || user.clinician?)
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
    new?
  end

  def change_systems_order?
    new?
  end

  def set_medal_data_config?
    new?
  end

  def update_full_order?
    new?
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

  def final_diagnoses?
    new?
  end

  def final_diagnoses_exclusions?
    new?
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

  def list?
    new?
  end

  def registration_triage_questions?
    new?
  end

  def medal_data_config?
    new?
  end

  def full_order?
    new?
  end

  def translations?
    new?
  end

  def regenerate_json?
    new?
  end

  def remove_triage_condition?
    new?
  end

  def update_list?
    new?
  end

  def job_status?
    new?
  end

  private

  def has_study_access?
    record = @record.is_a?(ActiveRecord::Relation) ? @record.first : @record
    @user.studies.where(id: record.algorithm.study_id).any?
  end
end
