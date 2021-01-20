class DiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :duplicate_algorithm_version_diagnostic_url
  def_delegator :@view, :edit_algorithm_version_diagnostic_url
  def_delegator :@view, :algorithm_version_diagnostic_url
  def_delegator :@view, :diagram_algorithm_version_diagnostic_url
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference: { source: 'Diagnostic.reference' },
      label: { source: 'Diagnostic.label_translations' },
      node: { source: 'Node.reference' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('open_diagram'), diagram_algorithm_version_diagnostic_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-dark') + " " +
        link_to(I18n.t('show'), algorithm_version_diagnostic_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-info') + " " +
        link_to(I18n.t('edit'), edit_algorithm_version_diagnostic_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-success') + " " +
        link_to(I18n.t('duplicate'), duplicate_algorithm_version_diagnostic_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-warning', method: :post) + " " +
        link_to(I18n.t('delete'), algorithm_version_diagnostic_url(params[:algorithm_id], params[:version_id], record), class: 'btn btn-outline-danger', method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        reference: record.full_reference,
        label: record.label,
        node: record.node.full_reference,
        last_update: date_format(record.updated_at),
        actions: actions
      }
    end
  end

  def get_raw_records
    Version.find(params[:version_id]).diagnostics.joins(:node)
  end
end
