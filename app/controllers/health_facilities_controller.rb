class HealthFacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_health_facility, only: [:show, :edit, :update]
  before_action :set_breadcrumb, only: [:show, :new, :edit]

  def index
    add_breadcrumb t('breadcrumbs.health_facilities')

    respond_to do |format|
      format.html
      format.json { render json: HealthFacilityDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @health_facility.name

    @device = Device.new
    @health_facility_access = HealthFacilityAccess.new
    @current_health_facility_access = HealthFacilityAccess.find_by(health_facility_id: params[:id], end_date: nil)
  end

  def new
    add_breadcrumb t('breadcrumbs.new')
    @health_facility = HealthFacility.new
  end

  def edit
    add_breadcrumb @health_facility.name, health_facility_url(@health_facility)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @health_facility = HealthFacility.new(health_facility_params)

    if @health_facility.save
      redirect_to health_facilities_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @health_facility.update(health_facility_params)
      redirect_to health_facilities_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # POST health_facilities/:id/add_device
  # @params health_facility_id [Integer] id of health_facility
  # @params device_id [Integer] id of device
  # @return redirect to health_facility#show with flash message
  # Add device to health_facility
  def add_device
    @health_facility = HealthFacility.find(params[:health_facility_id])
    device = Device.find(params[:device][:id])

    device.health_facility_id = @health_facility.id

    if device.save
      redirect_to @health_facility, notice: t('.success_add_device')
    else
      redirect_to @health_facility, danger: t('.error_add_device')
    end
  end

  # DELETE health_facilities/health_facility_id/devices/:device_id/remove_device
  # @params health_facility_id [Integer] id of health_facility
  # @params device_id [Integer] id of device
  # @return redirect to health_facility#show with flash message
  # Remove device from health_facility
  def remove_device
    @health_facility = HealthFacility.find(params[:health_facility_id])
    device = Device.find(params[:device_id])

    device.health_facility_id = nil

    if device.save
      redirect_to @health_facility, notice: t('.success_remove_device')
    else
      redirect_to @health_facility, danger: t('.error_remove_device')
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.health_facilities'), health_facilities_url
  end

  def set_health_facility
    @health_facility = HealthFacility.find(params[:id])
  end

  def health_facility_params
    params.require(:health_facility).permit(
      :name,
      :architecture,
      :local_data_ip,
      :main_data_ip,
      :pin_code,
      :longitude,
      :latitude,
      device_ids: [],
      medical_staffs_attributes: [
        :id,
        :first_name,
        :last_name,
        :role,
        :_destroy
      ]
    )
  end
end