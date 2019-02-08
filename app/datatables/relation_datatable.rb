class RelationDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :algorithm_algorithm_version_diagnostic_relation_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      id: { source: 'Relation.id' },
      reference: { source: 'Relation.node.reference' },
      type: { source: 'Relation.node.type' },
      label: { source: 'Relation.node.label' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), algorithm_algorithm_version_diagnostic_relation_url(params[:algorithm_id], params[:algorithm_version_id], params[:diagnostic_id], id: record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('destroy'), algorithm_algorithm_version_diagnostic_relation_url(params[:algorithm_id], params[:algorithm_version_id], params[:diagnostic_id], id: record), method: :delete, class: 'btn btn-outline-danger', data: { confirm: 'Are you sure?' })
      {
        id: record.id,
        reference: record.node.reference,
        type: record.node.type,
        label: record.node.label,
        children: record.nodes.map(&:label).join(' / '),
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Relation.where(relationable_id: params[:id], relationable_type: 'Diagnostic').includes([:node, :nodes, :children])
  end
end
