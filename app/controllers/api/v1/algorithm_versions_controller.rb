class Api::V1::AlgorithmVersionsController < Api::V1::ApplicationController

  def index
    render json: AlgorithmVersion.includes(:algorithm).to_json(include: { algorithm: { only: [:name, :description]}})
  end

end
