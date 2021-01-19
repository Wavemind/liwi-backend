# Configuration for health facility datatable display
class HealthFacilityDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :edit_health_facility_url
  def_delegator :@view, :health_facility_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      name: { source: 'HealthFacility.name' },
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), health_facility_url(record), class: 'btn btn-outline-info') + " " + link_to(I18n.t('edit'), edit_health_facility_url(record), class: 'btn btn-outline-success')
      {
        name: record.name,
        country: record.country,
        area: record.area,
        nb_people: record.devices.count,
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    HealthFacility.all
  end

end
