class DrugExclusionDatatable < ApplicationDatatable
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :remove_exclusion_algorithm_drugs_url

  def view_columns
    @view_columns ||= {
      excluding_drug_id: { source: 'Node.label_translations' },
      excluded_drug_id: { source: 'Node.label_translations' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('delete'), remove_exclusion_algorithm_drugs_url(params[:id], node_exclusion: {excluding_node_id: record.excluding_node_id, excluded_node_id: record.excluded_node_id}, format: :html), class: "btn btn-outline-danger", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        excluding_drug_id: record.excluding_node.reference_label(@default_language),
        excluded_drug_id: record.excluded_node.reference_label(@default_language),
        actions: actions
      }
    end
  end

  def get_raw_records
    drugs_ids = Algorithm.find(params[:id]).health_cares.drugs.map(&:id)
    NodeExclusion.includes(:excluded_node, :excluding_node).joins(:excluded_node, :excluding_node).drug.where(excluding_node_id: drugs_ids, excluded_node_id: drugs_ids)
  end
end
