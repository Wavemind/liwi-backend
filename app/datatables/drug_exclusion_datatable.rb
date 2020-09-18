class DrugExclusionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :remove_exclusion_algorithm_drugs_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      excluding_drug_id: { source: 'NodeExclusion.excluding_node_id' },
      excluded_drug_id: { source: 'NodeExclusion.excluded_node_id' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('delete'), remove_exclusion_algorithm_drugs_url(params[:id], node_exclusion: {excluding_node_id: record.excluding_node_id, excluded_node_id: record.excluded_node_id}, format: :html), class: "btn btn-outline-danger", method: :delete, data: { confirm: I18n.t('confirmation') })
      {
        excluding_drug_id: record.excluding_node.reference_label,
        excluded_drug_id: record.excluded_node.reference_label,
        actions: actions
      }
    end
  end

  def get_raw_records
    drugs_ids = Algorithm.find(params[:id]).health_cares.drugs.map(&:id)
    NodeExclusion.drug.where(excluding_node_id: drugs_ids, excluded_node_id: drugs_ids)
  end
end
