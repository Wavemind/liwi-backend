# Configuration for group access datatable display
class GroupAccessDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :date_format

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      created_at: { source: 'GroupAccess.created_at' },
      algorithm: { source: 'GroupAccess.algorithm_version.algorithm.name' },
      algorithm_version: { source: 'GroupAccess.algorithm_version.name' },
      end_date: { source: 'GroupAccess.end_date' },
    }
  end

  # Value display
  def data
    records.map do |record|
      {
        created_at: date_format(record.created_at),
        end_date: date_format(record.end_date),
        algorithm: record.algorithm_version.algorithm.name,
        algorithm_version: record.algorithm_version.name
      }
    end
  end

  # Activerecord request
  def get_raw_records
    GroupAccess.where(group_id: params[:id]).where.not(end_date: nil).includes([algorithm_version: [:algorithm]])
  end

end
