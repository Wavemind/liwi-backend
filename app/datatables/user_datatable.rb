class UserDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_user_url
  def_delegator :@view, :user_url
  def_delegator :@view, :deactivated_users_url
  def_delegator :@view, :activated_users_url
  def_delegator :@view, :datetime_format

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
      last_connection: { source: 'User.last_sign_in_at' },
      deactivated: { source: 'User.deactivated' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), user_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_user_url(record), class: 'btn btn-outline-info') + " "
      actions += record.deactivated ? link_to(I18n.t('.activated'), activated_users_url(record), class: 'btn btn-outline-danger', method: :post) : link_to(I18n.t('.deactivated'), deactivated_users_url(record), class: 'btn btn-outline-danger', method: :post)
      {
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        last_connection: datetime_format(record.last_sign_in_at),
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
