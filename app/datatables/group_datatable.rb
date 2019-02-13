# Configuration for group datatable display
class GroupDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :edit_group_url
  def_delegator :@view, :group_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      name: { source: 'Group.name' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), group_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_group_url(record), class: 'btn btn-outline-info')
      {
        name: record.name,
        nb_people: record.devices.count,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    Group.joins(:devices).all
  end

end
