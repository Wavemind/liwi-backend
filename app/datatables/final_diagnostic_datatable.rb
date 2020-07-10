class FinalDiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_version_diagnostic_final_diagnostic_url
  def_delegator :@view, :edit_algorithm_version_diagnostic_final_diagnostic_url
  def_delegator :@view, :diagram_algorithm_version_diagnostic_final_diagnostic_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'FinalDiagnostic.reference' },
      label: { source: 'FinalDiagnostic.label_translations' },
      description: { source: 'FinalDiagnostic.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), diagram_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:version_id], record.diagnostic, record), class: 'btn btn-outline-primary') + " "
      actions += link_to(I18n.t('edit'), edit_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:version_id], record.diagnostic, record), class: 'btn btn-outline-info') + " "
      actions += link_to(I18n.t('delete'), algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:version_id], record.diagnostic, record), class: "btn btn-outline-danger #{record.dependencies? ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        reference: record.full_reference,
        label: record.label,
        description: record.description,
        actions: actions
      }
    end
  end

  def get_raw_records
    Diagnostic.find(params[:diagnostic_id]).final_diagnostics
  end
end
