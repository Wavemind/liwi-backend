class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :activated, :deactivated]

  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, view_context: view_context) }
    end
  end

  def show
  end

  def new
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

  def update
    if @user.update(user_params)
      redirect_to users_url, notice: t('flash_message.success_updated')
    else
      render :edit
    end
  end

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

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :deactivated,
      :role_id,
      group_ids: []
    )
  end

end
