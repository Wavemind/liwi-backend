# Configuration for device datatable display
class DeviceDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  # Helpers
  def_delegator :@view, :link_to
  def_delegator :@view, :datetime_format
  def_delegator :@view, :device_url
  def_delegator :@view, :user_url
  def_delegator :@view, :health_facility_remove_device_url
  def_delegator :@view, :health_facility_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      mac_address: { source: 'Device.mac_address' },
      name: { source: 'Device.name' },
      brand: { source: 'Device.brand' },
      model: { source: 'Device.model' },
      health_facility: { source: 'HealthFacility.name' }
    }
  end

  # Value display
  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), device_url(record), class: 'btn btn-outline-info')

      # This table is used in 2 views, and actions are not the same
      if params[:from].present?
        actions += link_to(I18n.t('.remove'), health_facility_remove_device_url(params[:id], record), class: 'btn btn-outline-danger ml-2', method: :delete, data: { confirm: I18n.t('confirmation') })
      end
      {
        mac_address: record.mac_address,
        name: record.name,
        brand: record.brand,
        model: record.model,
        health_facility: record.health_facility.present? ? link_to(record.health_facility.name, health_facility_url(record.health_facility)) : '',
        last_activity: record.last_activity.present? ? datetime_format(Date.parse(record.last_activity['created_at'])) : '',
        last_user: record.last_activity.present? && record.last_activity['user'].present? ? link_to(record.last_activity['user']['first_name'] + ' ' + record.last_activity['user']['last_name'], user_url( record.last_activity['user']['id'])) : '',
        actions: actions
      }
    end
  end

  # Activerecord request
  def get_raw_records
    if params[:from].present?
      # Users from a health facility
      Device.all.includes(:health_facility).references(:health_facility).where(health_facility_id: params[:id])
    else
      # Devices
      Device.all.includes(:health_facility).references(:health_facility)
    end
  end

end
