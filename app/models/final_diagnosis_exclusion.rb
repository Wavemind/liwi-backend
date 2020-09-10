# Exclusion between final diagnosis
class FinalDiagnosisExclusion < ApplicationRecord

  belongs_to :excluding_diagnosis, class_name: 'FinalDiagnostic'
  belongs_to :excluded_diagnosis, class_name: 'FinalDiagnostic'

  validates_presence_of :excluded_diagnosis_id, :excluding_diagnosis_id
  validates :excluded_diagnosis_id, uniqueness: { scope: :excluding_diagnosis_id, message: I18n.t('errors.final_diagnosis_exclusion_unique') }
  after_validation :prevent_loop


  # Recursive loop to make sure it is not excluding a grand child of excluded diagnostic
  def is_excluding_itself(diagnosis_id)
    FinalDiagnosisExclusion.where(excluding_diagnosis_id: diagnosis_id).map do |exclusion|
      return true if exclusion.excluded_diagnosis_id == excluding_diagnosis_id || is_excluding_itself(exclusion.excluded_diagnosis_id)
    end
    false
  end

  # Ensure that the user is not trying to loop with excluding diagnostics.
  def prevent_loop
    if excluding_diagnosis_id == excluded_diagnosis_id || is_excluding_itself(excluded_diagnosis_id)
      self.errors.add(:base, I18n.t('final_diagnostics.validation.loop'))
      raise ActiveRecord::Rollback, I18n.t('final_diagnostics.validation.loop')
    end
  end

  # Recreate exclusions from final diagnoses pointing to old version to final diagnoses pointing to duplicated version
  def self.recreate_exclusions_after_duplicate(matching_final_diagnoses)
    matching_final_diagnoses.each do |key, value|
      FinalDiagnosisExclusion.where(excluding_diagnosis_id: key).map do |exclusion|
        FinalDiagnosisExclusion.create(excluding_diagnosis_id: value, excluded_diagnosis_id: matching_final_diagnoses[exclusion.excluded_diagnosis_id])
      end
    end
  end
end
