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

    if @group_access.save
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
