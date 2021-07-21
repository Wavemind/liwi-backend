class Api::V1::AlgorithmsController < Api::V1::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def index
    render json: Algorithm.all.select(:id, :name, :archived, :created_at, :updated_at)
  end

end
