class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update]

  def index
    respond_to do |format|
      format.html
      format.json { render json: GroupDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to groups_url, notice: t('success_created')
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_url, notice: t('success_updated')
    else
      render :edit
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name,
      )
  end
end
