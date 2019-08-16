class GroupAccessesController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: GroupAccessDatatable.new(params, view_context: view_context) }
    end
  end

  def create
    @group_access = GroupAccess.new(group_access_params)

    invalid_diagnostics = []
    # Validate every diagnostics of the version being published. Throw error if there is one or several diagnostics invalids with their reference.
    version = Version.find(group_access_params[:version_id])
    version.diagnostics.each do |diagnostic|
      diagnostic.manual_validate
      invalid_diagnostics.push(diagnostic.reference) if diagnostic.errors.messages.any?
    end

    if invalid_diagnostics.any?
      redirect_to @group_access.group, alert: t('flash_message.version.invalids_diagnostics', diagnostics: invalid_diagnostics)
    elsif @group_access.save
      redirect_to @group_access.group, notice: t('flash_message.success_created')
    else
      redirect_to @group_access.group
    end
  end

  private

  def group_access_params
    params.require(:group_access).permit(
      :id,
      :version_id,
      :group_id
      )
  end
end
