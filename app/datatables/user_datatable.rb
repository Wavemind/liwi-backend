class UserDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_user_url
  def_delegator :@view, :user_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      id: { source: 'User.id' },
      first_name: { source: 'User.first_name' },
      last_name: { source: 'User.last_name' },
      email: { source: 'User.email' },
      deactivated: { source: 'User.deactivated' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), user_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_user_url(record), class: 'btn btn-outline-info')
      {
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        deactivated: record.display_deactivated.html_safe,
        DT_RowId: record.id,
        action: actions
      }
    end
  end

  def get_raw_records
    User.all
  end

end
