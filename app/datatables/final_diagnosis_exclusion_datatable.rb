class FinalDiagnosisExclusionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :remove_exclusion_algorithm_version_final_diagnostics_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      excluding_diagnosis_id: { source: 'Node.label_translations' },
      excluded_diagnosis_id: { source: 'Node.label_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('delete'), remove_exclusion_algorithm_version_final_diagnostics_url(params[:algorithm_id], params[:id], node_exclusion: {excluding_node_id: record.excluding_node_id, excluded_node_id: record.excluded_node_id}, format: :html), class: "btn btn-outline-danger", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        excluding_diagnosis_id: record.excluding_node.reference_label,
        excluded_diagnosis_id: record.excluded_node.reference_label,
        actions: actions
      }
    end
  end

  def get_raw_records
    version_final_diagnosis_ids = Version.find(params[:id]).diagnostics.map(&:final_diagnostics).flatten.map(&:id)
    NodeExclusion.joins(:excluded_node, :excluding_node).final_diagnostic.where(excluding_node_id: version_final_diagnosis_ids, excluded_node_id: version_final_diagnosis_ids)
  end
end
