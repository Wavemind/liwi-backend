class InstanceDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :polymorphic_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      id: { source: 'Instance.id' },
      reference: { source: 'Instance.node.reference' },
      type: { source: 'Instance.node.type' },
      label: { source: 'Instance.node.label' },
    }
  end

  # Value display
  def data
    instanceable = params[:type].constantize.find(params[:id])

    records.map do |record|
      actions = link_to(I18n.t('show'), polymorphic_url([instanceable, record]), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('destroy'), polymorphic_url([instanceable, record]), method: :delete, class: 'btn btn-outline-danger', data: { confirm: 'Are you sure?' })
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
    instance = params[:type].constantize.find(params[:id])
    Instance.where(instanceable: instance).includes([:node, :nodes, :children])
  end
end