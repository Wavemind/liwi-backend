class AlgorithmVersionDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_algorithm_version_url
  def_delegator :@view, :algorithm_algorithm_version_url
  def_delegator :@view, :archive_algorithm_algorithm_version_url
  def_delegator :@view, :unarchive_algorithm_algorithm_version_url
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      version: { source: 'AlgorithmVersion.version' },
      algorithm: { source: 'Algorithm.name' },
      last_update: { source: 'AlgorithmVersion.updated_at' },
      creator: { source: 'User.last_name' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), algorithm_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_algorithm_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-info') + " "
      actions += record.archived ? link_to(I18n.t('unarchive'), unarchive_algorithm_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-danger', method: :put, data: { confirm: 'Are you sure?' }) : link_to(I18n.t('archive'), archive_algorithm_algorithm_version_url(record.algorithm, record), class: 'btn btn-outline-danger', method: :put, data: { confirm: 'Are you sure?' })
      {
        version: record.version,
        last_update: date_format(record.updated_at),
        creator: record.user.full_name,
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.find(params[:id]).algorithm_versions.joins(:algorithm, :user).includes(:user)
  end
end
