class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update]

  def index
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.groups')

    respond_to do |format|
      format.html
      format.json { render json: GroupDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.groups'), groups_url
    add_breadcrumb @group.name

    @device = Device.new
    @group_access = GroupAccess.new
    @current_group_access = GroupAccess.find_by(group_id: params[:id], end_date: nil)
  end

  def new
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.groups'), groups_url
    add_breadcrumb t('breadcrumbs.new')
    @group = Group.new
  end

  def edit
    add_breadcrumb t('breadcrumbs.home'), root_url
    add_breadcrumb t('breadcrumbs.groups'), groups_url
    add_breadcrumb @group.name, group_url(@group)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to groups_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # POST groups/:id/add_device
  # @params group_id [Integer] id of group
  # @params device_id [Integer] id of device
  # @return redirect to group#show with flash message
  # Add device to group
  def add_device
    @group = Group.find(params[:group_id])
    device = Device.find(params[:device][:id])

    device.group_id = @group.id

    if device.save
      redirect_to @group, notice: t('.success_add_device')
    else
      redirect_to @group, danger: t('.error_add_device')
    end
  end

  # DELETE groups/group_id/devices/:device_id/remove_device
  # @params group_id [Integer] id of group
  # @params device_id [Integer] id of device
  # @return redirect to group#show with flash message
  # Remove device from group
  def remove_device
    @group = Group.find(params[:group_id])
    device = Device.find(params[:device_id])

    device.group_id = nil

    if device.save
      redirect_to @group, notice: t('.success_remove_device')
    else
      redirect_to @group, danger: t('.error_remove_device')
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name,
      device_ids: []
    )
  end
end
