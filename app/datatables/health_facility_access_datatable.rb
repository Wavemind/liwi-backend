# Configuration for health_facility access datatable display
class HealthFacilityAccessDatatable < AjaxDatatablesRails::ActiveRecord
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
      created_at: { source: 'HealthFacilityAccess.created_at' },
      algorithm: { source: 'Version.algorithm.name' },
      version: { source: 'Version.name' },
      end_date: { source: 'HealthFacilityAccess.end_date' },
    }
  end

  # Value display
  def data
    records.map do |record|
      {
        created_at: date_format(record.created_at),
        end_date: date_format(record.end_date),
        algorithm: record.version.algorithm.name,
        version: record.version.name
      }
    end
  end

  # Activerecord request
  def get_raw_records
      HealthFacilityAccess.where(health_facility_id: params[:id]).where.not(end_date: nil).includes(version: [:algorithm]).references(version: [:algorithm])
  end

end
