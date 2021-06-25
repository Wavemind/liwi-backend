class HealthFacilitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_health_facility, only: [:show, :edit, :update, :add_device, :remove_device, :generate_stickers, :devices, :accesses, :medical_staff, :generate_stickers_view]
  before_action :set_breadcrumb, only: [:show, :new, :edit]
  before_action :set_countries, only: [:new, :edit, :create, :update]

  def index
    authorize policy_scope(HealthFacility)
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
    @studies = Study.all
    health_facility_access = HealthFacilityAccess.find_by(health_facility_id: params[:id], end_date: nil)
    @current_health_facility_access = health_facility_access.as_json(include: { version: { include: { algorithm: {only: [:id, :name]} }, only: [:id, :name, :job_id], methods: :display_label}})
    @versions = Version.includes(:algorithm).where.not(id: (health_facility_access.version_id if health_facility_access.present?), archived: true).as_json(only: [:id, :name])
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @health_facility = HealthFacility.new
    authorize @health_facility
  end

  def edit
    add_breadcrumb @health_facility.name, health_facility_url(@health_facility)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @health_facility = HealthFacility.new(health_facility_params)
    authorize @health_facility

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
    authorize @health_facility
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
    authorize @health_facility
    device = Device.find(params[:device_id])

    device.health_facility_id = nil

    if device.save
      redirect_to @health_facility, notice: t('.success_remove_device')
    else
      redirect_to @health_facility, danger: t('.error_remove_device')
    end
  end

  # POST health_facilities/health_facility_id/devices/:device_id/generate_stickers
  # @params health_facility_id [Integer] id of health_facility
  # @params health_facility [Hash] contains the data filled in the form
  # Generates the PDF containing the stickers and sends the file to the browser
  def generate_stickers
    if sticker_params[:study_id].present?
      if sticker_params[:number_of_stickers].to_i > 1
        @study_id = Study.find(sticker_params[:study_id])
        @number_of_stickers = sticker_params[:number_of_stickers]
        respond_to do |format|
          format.pdf do
            tempfile = Tempfile.new(["tempPDF", ".pdf"], Rails.root.join("tmp"))
            pdf = StickerPdf.new(@health_facility, @study_id, @number_of_stickers)
            tempfile.write pdf.render_file tempfile.path
            File.open(tempfile, 'r') do |f|
              send_data(f.read, filename: "uuid_stickers_#{Time.now.strftime('%Y%m%d_%H%M%S')}.pdf", type: "application/pdf")
            end
            tempfile.close(true)
          end
        end
      else
        redirect_to health_facility_url(@health_facility, panel: 'generate_stickers'), alert: t('health_facilities.sticker_generator.errors.must_be_positive')
      end
    else
      redirect_to health_facility_url(@health_facility, panel: 'generate_stickers'), alert: t('.sticker_generator.errors.missing_study_id')
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def accesses
    health_facility_access = HealthFacilityAccess.find_by(health_facility_id: params[:id], end_date: nil)
    @current_health_facility_access = health_facility_access.as_json(include: { version: { include: { algorithm: {only: [:id, :name]} }, only: [:id, :name, :job_id], methods: :display_label}})
    @versions = Version.includes(:algorithm).where.not(id: (health_facility_access.version_id if health_facility_access.present?), archived: true).as_json(only: [:id, :name])

    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def devices
    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def generate_stickers_view
    respond_to do |format|
      format.js { }
    end
  end

  # @params algorithm [Algorithm] current algorithm
  # @return json of drugs
  # All managements exclusions
  def medical_staff
    respond_to do |format|
      format.js { }
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.health_facilities'), health_facilities_url
  end

  def set_health_facility
    @health_facility = params[:id] ? HealthFacility.find(params[:id]) : HealthFacility.find(params[:health_facility_id])
    authorize @health_facility
  end

  def set_countries
    @countries = CS.countries.values.sort.select{ |country| country != 'country_name'}
  end

  def health_facility_params
    params.require(:health_facility).permit(
      :name,
      :architecture,
      :local_data_ip,
      :main_data_ip,
      :pin_code,
      :country,
      :area,
      :longitude,
      :latitude,
      :study_id,
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

  def sticker_params
    params.require(:sticker).permit(
        :health_facility_id,
        :study_id,
        :number_of_stickers,
        )
  end
end
