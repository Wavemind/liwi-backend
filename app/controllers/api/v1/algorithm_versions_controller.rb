class Api::V1::AlgorithmVersionsController < Api::V1::ApplicationController

  def index
    render json: AlgorithmVersionsService.generate_hash(AlgorithmVersion.first.id)
  end

end
