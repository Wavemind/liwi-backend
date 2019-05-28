class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breadcrumb, only: [:index, :show, :new]
  before_action :set_user, only: [:show, :edit, :update, :activated, :deactivated]

  def index
    add_breadcrumb t('breadcrumbs.users')

    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context) }
    end
  end

  def show
    add_breadcrumb @user.full_name
  end

  def new
    add_breadcrumb t('breadcrumbs.new')

    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      User.invite!(user_params)
      redirect_to users_url, notice: t('flash_message.success_created')
    else
      render :new
    end
  end

  def edit

    add_breadcrumb t('breadcrumbs.users'), users_url
    add_breadcrumb @user.full_name, user_url(@user)
    add_breadcrumb t('breadcrumbs.edit')
  end

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

  # POST users/:id/activated
  # @params id [Integer] id of user
  # @return redirect to users#index with flash message
  # Activate user account
  def activated
    @user.deactivated = false

    if @user.save
      redirect_to users_url, notice: t('flash_message.success_created')
    else
      redirect_to users_url, danger: t('flash_message.update_fail')
    end
  end

  # POST users/:id/deactivated
  # @params id [Integer] id of user
  # @return redirect to users#index with flash message
  # Deactivate user account
  def deactivated
    @user.deactivated = true

    if @user.save
      redirect_to users_url, notice: t('flash_message.success_created')
    else
      redirect_to users_url, danger: t('flash_message.update_fail')
    end
  end

  private
  def set_breadcrumb
    add_breadcrumb t('breadcrumbs.users'), users_url
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :deactivated,
      :role_id
    )
  end

end
