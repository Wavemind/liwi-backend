class DiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_algorithm_version_diagnostic_url
  def_delegator :@view, :algorithm_algorithm_version_diagnostic_url
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'Diagnostic.reference' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), algorithm_algorithm_version_diagnostic_url(params[:algorithm_id], params[:id], record), class: 'btn btn-outline-primary') + " " +
        link_to(I18n.t('edit'), edit_algorithm_algorithm_version_diagnostic_url(params[:algorithm_id], params[:id], record), class: 'btn btn-outline-info')
      {
        reference: record.reference,
        label: record.label,
        last_update: date_format(record.updated_at),
        actions: actions
      }
    end
  end

  def get_raw_records
    AlgorithmVersion.find(params[:id]).diagnostics
  end
end
