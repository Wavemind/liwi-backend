# Configuration for medical staff datatable display
class MedicalStaffDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  # Column configuration
  def view_columns
    @view_columns ||= {
      first_name: { source: 'MedicalStaff.first_name' },
      last_name: { source: 'MedicalStaff.last_name' },
      role: { source: 'MedicalStaff.role' },
    }
  end

  # Value display
  def data
    records.map do |record|
      {
        first_name: record.first_name,
        last_name: record.last_name,
        role: I18n.t("medical_staffs.roles.#{record.role}"),
      }
    end
  end

  # Activerecord request
  def get_raw_records
    HealthFacility.find(params[:health_facility_id]).medical_staffs
  end

end
