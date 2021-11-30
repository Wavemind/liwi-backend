class Api::V1::HealthFacilitiesController < Api::V1::ApplicationController
  def show
    health_facility = HealthFacility.find_by_id(params[:id])
    if health_facility.present?
      render json: health_facility.as_json(except: [:pin_code, :token])
    else
      render json: { errors: t('api.v1.health_facilities.show.no_health_facility') }, status: :unprocessable_entity
    end
  end

  # GET /health_facilities/get_from_study
  # Send health facilities with its devices and medical staffs from a study
  def get_from_study
    study = Study.find_by(label: params[:study_label])
    if study.present?
      render json: study.health_facilities.as_json(include: [:medical_staffs, :devices])
    else
      render json: { errors: t('api.v1.health_facilities.get_from_study.no_study') }, status: :unprocessable_entity
    end
  end
end
