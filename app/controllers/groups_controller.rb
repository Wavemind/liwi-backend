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
    @user = User.new
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

  # @params group_id [Integer] id of group
  # @params user_id [Integer] id of user
  # @return redirect to group#show with flash message
  # Remove user from group
  def remove_user
    @group = Group.find(params[:group_id])
    user = User.find(params[:user_id])

    if @group.users.delete(user)
      redirect_to @group, notice: t('.success_remove_user')
    else
      redirect_to @group, danger: t('.error_remove_user')
    end
  end

  # @params group_id [Integer] id of group
  # @params user_id [Integer] id of user
  # @return redirect to group#show with flash message
  # Add user to group
  def add_user
    @group = Group.find(params[:group_id])
    user = User.find(params[:user][:id])

    @group.users << user

    if @group.save
      redirect_to @group, notice: t('.success_add_user')
    else
      redirect_to @group, danger: t('.error_add_user')
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(
      :name,
      user_ids: []
    )
  end
end
