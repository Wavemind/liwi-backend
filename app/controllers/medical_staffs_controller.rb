class MedicalStaffsController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize policy_scope(HealthFacility)
    respond_to do |format|
      format.html
      format.json {render json: MedicalStaffDatatable.new(params, view_context: view_context)}
    end
  end

end
