class DiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_algorithm_version_diagnostic_url
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'Diagnostic.id' },
      name: { source: 'Diagnostic.name' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_algorithm_version_diagnostic_url(params[:algorithm_id], params[:id], record), class: 'btn btn-outline-info')
      {
        id: record.id,
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
