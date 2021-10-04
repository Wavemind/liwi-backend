class VersionFinalDiagnosisDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_version_diagnosis_final_diagnosis_url

  def view_columns
    @view_columns ||= {
      id: { source: 'FinalDiagnosis.id' },
      reference: { source: 'FinalDiagnosis.reference' },
      label: { source: 'FinalDiagnosis.label_translations' },
      cc: { source: 'Diagnosis.node_id' },
      diagnosis: { source: 'FinalDiagnosis.diagnosis_id' },
      description: { source: 'FinalDiagnosis.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_version_diagnosis_final_diagnosis_url(params[:algorithm_id], params[:id], record.diagnosis, record, source: 'version'), class: 'btn btn-outline-success')
      {
        id: record.id,
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        diagnosis: record.diagnosis.reference_label(@default_language),
        cc: record.diagnosis.node.reference_label(@default_language),
        description: record.send("description_#{@default_language}"),
        actions: actions,
      }
    end
  end

  def get_raw_records
    FinalDiagnosis.includes(diagnosis: [:node]).joins(diagnosis: [:node]).where(diagnosis_id: Version.find(params[:id]).diagnoses.map(&:id))
  end
end
