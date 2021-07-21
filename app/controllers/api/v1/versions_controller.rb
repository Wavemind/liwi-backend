class Api::V1::VersionsController < Api::V1::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  # THIS MIGHT BE SOME VERY DUMB SHIT BUT CAN'T BE ARESED TO FIX IT WITCH LOVE YOUR BOSS <3
  skip_before_action :verify_authenticity_token, only: [:retrieve_algorithm_version]

  before_action :authenticate_user!, only: [:create]

  def index
    algorithm = Algorithm.find_by_id(params[:algorithm_id])
    if algorithm
      render json: algorithm.versions.select(:id, :name, :archived, :created_at, :updated_at, :is_arm_control, :algorithm_id)
    else
      render json: { errors: t('api.v1.versions.show.invalid_algorithm') }, status: :unprocessable_entity
    end
  end

  def show
    version = Version.find_by_id(params[:id])
    if version
      render json: version.as_json(except: [:user_id])
    else
      render json: { errors: t('api.v1.versions.show.invalid_version') }, status: :unprocessable_entity
    end
  end

  def retrieve_algorithm_version
    # Get the devise make the request
    device = Device.find_by(mac_address: params[:mac_address])

    if device.present?
      if device.health_facility.present?
        if device.health_facility.token == request.headers['health-facility-token']
          # Find the algorithm version available for this health facility
          version = device.health_facility.versions.where('health_facility_accesses.end_date IS NULL').first

          Activity.create(
            version: version,
            device: device,
            user: current_user,
            timezone: params[:timezone],
            latitude: params[:latitude],
            longitude: params[:longitude],
            )

          if version.present?
            medal_r_json_version = params[:json_version]
            if medal_r_json_version.to_i == version.medal_r_json_version
              render json: {}, status: 204
            else
              render json: version.medal_r_json
            end
          else
            render json: { errors: t('api.v1.versions.index.no_version') }, status: :unprocessable_entity
          end
        else
          render json:  { errors: t('api.v1.versions.index.invalid_token') }, status: :unprocessable_entity
        end
      else
        render json: { errors: t('api.v1.versions.index.no_health_facility') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('api.v1.versions.index.device_not_exist') }, status: :unprocessable_entity
    end
  end

  def json_test
    if params[:secret] == 'jest'
      version = Version.find(params[:version_id])
      render json: version.medal_r_json
    else
      render json: { errors: t('api.v1.versions.index.invalid_token') }, status: :unprocessable_entity
    end
  end

  # PUT /versions/json_from_facility
  # @params health_facility_id [Integer]
  # Get version from facility id and send back the json associated to it.
  def json_from_facility
    if params[:health_facility_id].present?
      facility = HealthFacility.find_by(id: params[:health_facility_id])
      if facility.present?
        facility_version = facility.health_facility_accesses.where(end_date: nil).first.version
        medal_r_json_version = params[:json_version]
        if medal_r_json_version.to_i == facility_version.medal_r_json_version
          render json: {}, status: 204
        else
          render json: facility_version.medal_r_json
        end
      else
        render json: { errors: t('api.v1.versions.index.invalid_health_facility') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('api.v1.versions.index.no_health_facility_id') }, status: :unprocessable_entity
    end
  end

  # PUT /versions/facility_attributes
  # @params health_facility_id [Integer]
  # Get the facility from id and send back its attributes
  def facility_attributes
    if params[:health_facility_id].present?
      facility = HealthFacility.find_by(id: params[:health_facility_id])
      if facility.present?
        render json: facility.as_json(include: :medical_staffs)
      else
        render json: { errors: t('api.v1.versions.index.invalid_health_facility') }, status: :unprocessable_entity
      end
    else
      render json: { errors: t('api.v1.versions.index.no_health_facility_id') }, status: :unprocessable_entity
    end
  end

  # PUT /versions/medal_data_config
  # @params health_facility_id [Integer]
  # Get the MedAL-data config within basic questions, medal-data related questions and study id
  def medal_data_config
    if params[:version_id].present?
      version = Version.find_by(id: params[:version_id])
      if version.present?
        config = version.medal_data_config.merge(version.algorithm.medal_r_config['basic_questions'])
        config['study_id'] = version.algorithm.study.label
        render json: config
      else
        render json: { errors: t('api.v1.versions.index.invalid_version') }, status: :unprocessable_entity
      end
    end
  end

end
