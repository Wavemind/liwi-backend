class VersionFinalDiagnosticDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to

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
      {
        id: record.id,
        reference: record.full_reference,
        label: record.label,
        diagnostic: record.diagnostic.reference_label,
        cc: record.diagnostic.node.reference_label,
        description: record.description,
      }
    end
  end

  def get_raw_records
    FinalDiagnostic.includes(diagnostic: [:node]).joins(diagnostic: [:node]).where(diagnostic_id: Version.find(params[:id]).diagnostics.map(&:id))
  end
end
