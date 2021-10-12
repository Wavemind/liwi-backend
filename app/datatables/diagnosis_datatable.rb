class DiagnosisDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :duplicate_algorithm_version_diagnosis_url
  def_delegator :@view, :edit_algorithm_version_diagnosis_url
  def_delegator :@view, :algorithm_version_diagnosis_url
  def_delegator :@view, :diagram_algorithm_version_diagnosis_url
  def_delegator :@view, :date_format

  def view_columns
    @view_columns ||= {
      reference: { source: 'Diagnosis.reference' },
      label: { source: 'Diagnosis.label_translations' },
      node: { source: 'Node.reference' },
      last_update: { source: 'Diagnosis.updated_at' }
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('open_diagram'), diagram_algorithm_version_diagnosis_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-dark') + " " +
        link_to(I18n.t('show'), algorithm_version_diagnosis_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-info') + " " +
        link_to(I18n.t('edit'), edit_algorithm_version_diagnosis_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-success') + " " +
        link_to(I18n.t('duplicate'), duplicate_algorithm_version_diagnosis_url(params[:algorithm_id], params[:version_id], record), class: "btn btn-outline-warning #{@version.in_prod ? 'disabled' : ''}", method: :post) + " " +
        link_to(I18n.t('delete'), algorithm_version_diagnosis_url(params[:algorithm_id], params[:version_id], record), class: "btn btn-outline-danger #{@version.in_prod ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        reference: record.full_reference,
        label: record.send("label_#{@default_language}"),
        node: record.node.full_reference,
        last_update: date_format(record.updated_at),
        actions: actions
      }
    end
  end

  def get_raw_records
    @version = Version.find(params[:version_id])
    @version.diagnoses.includes(:node).joins(:node)
  end
end
