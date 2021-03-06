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

        invalid_diagnoses = []
        # Validate every diagnoses of the version being published. Throw error if there is one or several diagnoses invalids with their reference.
        version = Version.find(health_facility_access_params[:version_id])

        village_question_id = version.algorithm.medal_r_config['optional_basic_questions']['village_question_id']
        if version.components.where(node_id: village_question_id).any? && version.algorithm.village_json.nil?
          render json: { success: false, message: t('flash_message.version.missing_villages') } and return
        end

        version.diagnoses.each do |diagnosis|
          diagnosis.manual_validate
          invalid_diagnoses.push(diagnosis.full_reference) if diagnosis.errors.messages.any?
        end

        if invalid_diagnoses.any?
          render json: { success: false, message: t('flash_message.version.invalids_diagnoses', diagnoses: invalid_diagnoses) }
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
