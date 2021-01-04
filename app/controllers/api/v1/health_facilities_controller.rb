class Api::V1::HealthFacilitiesController < Api::V1::ApplicationController
  def show
    health_facility = HealthFacility.find_by_id(params[:id])
    if health_facility.present?
      render json: health_facility
    else
      render json: { errors: t('api.v1.health_facilities.show.no_health_facility') }, status: :unprocessable_entity
    end
  end
end
