class FinalDiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_algorithm_version_diagnostic_final_diagnostic_url
  def_delegator :@view, :edit_algorithm_algorithm_version_diagnostic_final_diagnostic_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'FinalDiagnostic.reference' },
      label: { source: 'FinalDiagnostic.label' },
      description: { source: 'FinalDiagnostic.description' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), algorithm_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:algorithm_version_id], record.diagnostic, record), class: 'btn btn-outline-primary') + " "
      actions += link_to(I18n.t('edit'), edit_algorithm_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:algorithm_version_id], record.diagnostic, record), class: 'btn btn-outline-info') + " "
      actions += link_to(I18n.t('delete'), algorithm_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:algorithm_version_id], record.diagnostic, record), class: 'btn btn-outline-danger', method: :delete, data: { confirm: 'Are you sure?' })
      {
        reference: record.reference,
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
