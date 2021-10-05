class TwoFactorSettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    authorize policy_scope(User)
    if current_user.otp_required_for_login
      return redirect_to edit_user_registration_path, alert: t('two_factor_settings.flash_messages.two_factor_already_enable')
    end

    current_user.generate_two_factor_secret_if_missing!
  end

  def create
    authorize policy_scope(User)
    unless current_user.valid_password?(enable_2fa_params[:password])
    flash.alert = t('two_factor_settings.flash_messages.two_factor_already_enable')
      return render :new
    end

    if current_user.validate_and_consume_otp!(enable_2fa_params[:code])
      current_user.enable_two_factor!
      redirect_to edit_two_factor_settings_path, notice: t('two_factor_settings.flash_messages.incorrect_password')
    else
      flash.alert = t('two_factor_settings.flash_messages.incorrect_code')
      render :new
    end
  end

  def edit
    authorize policy_scope(User)
    unless current_user.otp_required_for_login
      return redirect_to new_two_factor_settings_path, alert: t('two_factor_settings.flash_messages.please_enable_two_factor')
    end

    if current_user.two_factor_backup_codes_generated?
      return redirect_to edit_user_registration_path, alert: t('two_factor_settings.flash_messages.already_see_backup_code')
    end

    @backup_codes = current_user.generate_otp_backup_codes!
    current_user.save!
  end

  def destroy
    authorize policy_scope(User)
    if current_user.disable_two_factor!
      redirect_to edit_user_registration_path, notice: t('two_factor_settings.flash_messages.success_disabled_two_factor')
    else
      redirect_back fallback_location: root_path, alert: t('two_factor_settings.flash_messages.fail_disabled_two_factor')
    end
  end

  private

  def enable_2fa_params
    params.require(:two_fa).permit(:code, :password)
  end

end
