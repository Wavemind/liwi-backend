class HealthFacilityAccessesController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: HealthFacilityAccessDatatable.new(params, view_context: view_context) }
    end
  end

  def create
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        @health_facility_access = HealthFacilityAccess.new(health_facility_access_params)

        invalid_diagnostics = []
        # Validate every diagnostics of the version being published. Throw error if there is one or several diagnostics invalids with their reference.
        version = Version.find(health_facility_access_params[:version_id])
        version.diagnostics.each do |diagnostic|
          diagnostic.manual_validate
          invalid_diagnostics.push(diagnostic.full_reference) if diagnostic.errors.messages.any?
        end

        if invalid_diagnostics.any?
          redirect_to @health_facility_access.health_facility, alert: t('flash_message.version.invalids_diagnostics', diagnostics: invalid_diagnostics)
        else
          if @health_facility_access.save && VersionsService.generate_version_hash(version.id)
            redirect_to @health_facility_access.health_facility, notice: t('flash_message.success_created')
          else
            redirect_to @health_facility_access.health_facility
          end
        end
      rescue => e
        puts e
        puts e.backtrace
        redirect_to @health_facility_access.health_facility, alert: t('flash_message.json_error')
        raise ActiveRecord::Rollback, ''
      end
    end
  end

  private

  def health_facility_access_params
    params.require(:health_facility_access).permit(
      :id,
      :version_id,
      :health_facility_id
      )
  end
end
