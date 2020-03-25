class AlgorithmDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :edit_algorithm_url
  def_delegator :@view, :algorithm_url
  def_delegator :@view, :algorithm_version_url
  def_delegator :@view, :archive_algorithm_url
  def_delegator :@view, :unarchive_algorithm_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      name: { source: 'Algorithm.name' },
      description: { source: 'Algorithm.description' },
      creator: { source: 'User.last_name' },
    }
  end

  def versions(record)
    badges = ''
    record.versions.map do |version|
      badges += " <span class='badge badge-info'>#{link_to(version.name, algorithm_version_url(record, version))}</span>"
    end
    badges
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), algorithm_url(record), class: 'btn btn-outline-primary') + " " + link_to(I18n.t('edit'), edit_algorithm_url(record), class: 'btn btn-outline-info') + " "
      actions += record.archived ? link_to(I18n.t('unarchive'), unarchive_algorithm_url(record), class: 'btn btn-outline-danger', method: :put, data: { confirm: 'Are you sure?' }) : link_to(I18n.t('archive'), archive_algorithm_url(record), class: 'btn btn-outline-danger', method: :put, data: { confirm: 'Are you sure?' })
      {
        name: record.name,
        description: record.description,
        versions: versions(record).html_safe,
        creator: record.user.full_name,
        actions: actions
      }
    end
  end

  def get_raw_records
    Algorithm.includes(:user).joins(:user).distinct
  end
end
