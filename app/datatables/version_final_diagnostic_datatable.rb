class VersionFinalDiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_version_diagnostic_final_diagnostic_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'FinalDiagnostic.id' },
      reference: { source: 'FinalDiagnostic.reference' },
      label: { source: 'FinalDiagnostic.label_translations' },
      cc: { source: 'Diagnostic.node_id' },
      diagnostic: { source: 'FinalDiagnostic.diagnostic_id' },
      description: { source: 'FinalDiagnostic.description_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('edit'), edit_algorithm_version_diagnostic_final_diagnostic_url(params[:algorithm_id], params[:id], record.diagnostic, record, source: 'version'), class: 'btn btn-outline-info')
      {
        id: record.id,
        reference: record.full_reference,
        label: record.label,
        diagnostic: record.diagnostic.reference_label,
        cc: record.diagnostic.node.reference_label,
        description: record.description,
        actions: actions,
      }
    end
  end

  def get_raw_records
    FinalDiagnostic.includes(diagnostic: [:node]).joins(diagnostic: [:node]).where(diagnostic_id: Version.find(params[:id]).diagnostics.map(&:id))
  end
end
