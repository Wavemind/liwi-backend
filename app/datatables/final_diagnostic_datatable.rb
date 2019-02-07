class DiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_algorithm_version_diagnostic_final_diagnostic_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'FinalDiagnostic.reference' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('delete'), algorithm_algorithm_version_diagnostic_final_diagnostic_url(record.diagnostic, record), class: 'btn btn-outline-danger', method: :delete, data: { confirm: 'Are you sure?' })
      {
        reference: record.reference,
        label: record.label,
        last_update: date_format(record.updated_at),
        actions: actions
      }
    end
  end

  def get_raw_records
    Diagnostic.find(params[:id]).final_diagnostics
  end
end
