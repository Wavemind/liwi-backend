class DeviceDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to
  def_delegator :@view, :datetime_format
  def_delegator :@view, :device_url
  def_delegator :@view, :user_url

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    @view_columns ||= {
      reference_number: { source: 'Device.reference_number' },
      name: { source: 'Device.name' },
      brand: { source: 'Device.brand' },
      model: { source: 'Device.model' },
    }
  end

  def data
    records.map do |record|
      actions = link_to(I18n.t('show'), device_url(record), class: 'btn btn-outline-primary')
      {
        reference_number: record.reference_number,
        name: record.name,
        brand: record.brand,
        model: record.model,
        last_activity: record.last_activity.present? ? datetime_format(record.last_activity['created_at']) : '',
        last_user: record.last_activity.present? && record.last_activity['user'].present? ? link_to(record.last_activity['user']['first_name'] + ' ' + record.last_activity['user']['last_name'], user_url( record.last_activity['user']['id'])) : '',
        actions: actions
      }
    end
  end

  def get_raw_records
    Device.all
  end

end
