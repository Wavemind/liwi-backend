class HealthFacilityAccessesController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize policy_scope(HealthFacility)
    respond_to do |format|
      format.html
      format.json { render json: HealthFacilityAccessDatatable.new(params, view_context: view_context) }
    end
  end

  def create
    ActiveRecord::Base.transaction(requires_new: true) do
      begin
        @health_facility_access = HealthFacilityAccess.new(health_facility_access_params)
        authorize @health_facility_access

        invalid_diagnostics = []
        # Validate every diagnostics of the version being published. Throw error if there is one or several diagnostics invalids with their reference.
        version = Version.find(health_facility_access_params[:version_id])

        if version.algorithm.village_json.nil?
          render json: { success: false, message: t('flash_message.version.missing_villages') } and return
        end

        version.diagnostics.each do |diagnostic|
          diagnostic.manual_validate
          invalid_diagnostics.push(diagnostic.full_reference) if diagnostic.errors.messages.any?
        end

        if invalid_diagnostics.any?
          render json: { success: false, message: t('flash_message.version.invalids_diagnostics', diagnostics: invalid_diagnostics) }
        else
          missing_nodes = Node.where(id: version.identify_missing_questions)

          if missing_nodes.any?
            render json: { success: false, message: t('flash_message.missing_nodes_error', missing_nodes: missing_nodes.map(&:reference_label)) }
          else
            if @health_facility_access.save
              job_id = GenerateJsonJob.perform_later(version.id)
              version.update(job_id: job_id.provider_job_id)
              @current_health_facility_access = @health_facility_access.as_json(include: { version: { include: { algorithm: {only: [:id, :name]} }, only: [:id, :name, :job_id], methods: :display_label}})
              render json: { success: true, version: version.reload, current_health_facility_access: @current_health_facility_access }
            else
              render json: { success: false, message: t('flash_message.json_error') }
            end
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
