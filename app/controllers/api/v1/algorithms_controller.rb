class Api::V1::AlgorithmsController < Api::V1::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token, only: [:emergency_content]

  def index
    render json: Algorithm.all.select(:id, :name, :archived, :created_at, :updated_at)
  end

  # POST /algorithms/:id/emergency_content
  # @params algorithm_id [Integer]
  # Send emergency_content if the version is not the same
  def emergency_content
    algorithm = Algorithm.find_by(id: params[:id])

    if algorithm.nil?
      render json: { errors: t('api.v1.algorithms.invalid_algorithm') }, status: :unprocessable_entity
    elsif algorithm.emergency_content_version == params[:emergency_content_version].to_i
      render json: {}, status: 204
    else
      render algorithm.as_json(only: [:emergency_content, :emergency_content_version])
    end
  end

end
