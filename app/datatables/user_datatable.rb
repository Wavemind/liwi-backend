class UserDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_user_url
  def_delegator :@view, :user_url
  def_delegator :@view, :deactivated_users_url
  def_delegator :@view, :activated_users_url
  def_delegator :@view, :remove_user_from_group_url
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
      if params[:from].present?
        actions += link_to(I18n.t('.remove'), remove_user_from_group_url(params[:id], record), class: 'btn btn-outline-danger', method: :delete, data: { confirm: 'Are you sure?' })
      else
        actions += record.deactivated ? link_to(I18n.t('.activated'), activated_users_url(record), class: 'btn btn-outline-danger', method: :post, data: { confirm: 'Are you sure?' }) : link_to(I18n.t('.deactivated'), deactivated_users_url(record), class: 'btn btn-outline-danger', method: :post, data: { confirm: 'Are you sure?' })
      end

      {
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,
        email: record.email,
        last_connection: datetime_format(record.last_sign_in_at),
        deactivated: record.display_deactivated.html_safe,
        action: actions
      }
    end
  end

  def get_raw_records
    if params[:from].present?
      User.joins(:group_users).where("group_users.group_id = #{params[:id]}")
    else
      User.all
    end
  end

end
