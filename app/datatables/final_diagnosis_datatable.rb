class FinalDiagnosisDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_version_diagnosis_final_diagnosis_url
  def_delegator :@view, :edit_algorithm_version_diagnosis_final_diagnosis_url
  def_delegator :@view, :diagram_algorithm_version_diagnosis_final_diagnosis_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'FinalDiagnosis.reference' },
      label: { source: 'FinalDiagnosis.label_translations' },
      description: { source: 'FinalDiagnosis.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), diagram_algorithm_version_diagnosis_final_diagnosis_url(params[:algorithm_id], params[:version_id], record.diagnosis, record), class: 'btn btn-outline-info') + " "
      actions += link_to(I18n.t('edit'), edit_algorithm_version_diagnosis_final_diagnosis_url(params[:algorithm_id], params[:version_id], record.diagnosis, record), class: 'btn btn-outline-success') + " "
      actions += link_to(I18n.t('delete'), algorithm_version_diagnosis_final_diagnosis_url(params[:algorithm_id], params[:version_id], record.diagnosis, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        reference: record.full_reference,
        label: record.label,
        description: record.description,
        actions: actions
      }
    end
  end

  def get_raw_records
    Diagnosis.find(params[:diagnosis_id]).final_diagnoses
  end
end
