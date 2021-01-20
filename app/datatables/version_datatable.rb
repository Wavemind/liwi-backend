class VersionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_version_url
  def_delegator :@view, :algorithm_version_url
  def_delegator :@view, :archive_algorithm_version_url
  def_delegator :@view, :unarchive_algorithm_version_url
  def_delegator :@view, :duplicate_algorithm_version_url
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      name: { source: 'Version.name' },
      algorithm: { source: 'Algorithm.name' },
      last_update: { source: 'Version.updated_at' },
      creator: { source: 'User.last_name' },
    }
  end

  def data
    records.map do |record|
      actions =
        link_to(I18n.t('show'), algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-info') + " " +
        link_to(I18n.t('edit'), edit_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-success') + " " +
        link_to(I18n.t('duplicate'), duplicate_algorithm_version_url(params[:algorithm_id], record), class: 'btn btn-outline-warning', method: :post) + " "
        actions += record.archived ? link_to(I18n.t('unarchive'), unarchive_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-danger', method: :put, data: { confirm: I18n.t('confirmation') }) : link_to(I18n.t('archive'), archive_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-danger', method: :put, data: { confirm: I18n.t('confirmation') })
      {
        name: record.name,
        last_update: date_format(record.updated_at),
        creator: record.user.full_name,
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).versions.joins(:algorithm, :user).includes(:user)
  end
end
