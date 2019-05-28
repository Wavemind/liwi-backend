class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: [:show, :edit, :update]

  def index
    add_breadcrumb t('breadcrumbs.roles')

    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context) }
    end
  end

  def show

  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to roles_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      redirect_to roles_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(
      :name,
    )
  end
end
