class GroupDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_group_url
  def_delegator :@view, :group_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'Group.id' },
      name: { source: 'Group.name' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), group_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_group_url(record), class: 'btn btn-outline-info')
      {
        id: record.id,
        name: record.name,
        nb_people: record.users.count,
        actions: actions
      }
    end
  end

  def get_raw_records
    Group.all
  end

end
