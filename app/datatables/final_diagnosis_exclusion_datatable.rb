class FinalDiagnosisExclusionDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :remove_exclusion_algorithm_version_final_diagnoses_url

  def view_columns
    @view_columns ||= {
      excluding_diagnosis_id: { source: 'Node.label_translations' },
      excluded_diagnosis_id: { source: 'Node.label_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('delete'), remove_exclusion_algorithm_version_final_diagnoses_url(params[:algorithm_id], params[:id], node_exclusion: {excluding_node_id: record.excluding_node_id, excluded_node_id: record.excluded_node_id}, format: :html), class: "btn btn-outline-danger #{@version.in_prod ? 'disabled' : ''}", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        excluding_diagnosis_id: record.excluding_node.reference_label(@default_language),
        excluded_diagnosis_id: record.excluded_node.reference_label(@default_language),
        actions: actions
      }
    end
  end

  def get_raw_records
    @version = Version.find(params[:id])
    version_final_diagnosis_ids = @version.diagnoses.includes(:final_diagnoses).map(&:final_diagnoses).flatten.map(&:id)
    NodeExclusion.includes(:excluded_node, :excluding_node).joins(:excluded_node, :excluding_node).final_diagnosis.where(excluding_node_id: version_final_diagnosis_ids, excluded_node_id: version_final_diagnosis_ids)
  end
end
