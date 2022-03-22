module AuthenticateWithOtpTwoFactor
  extend ActiveSupport::Concern

  # Proceed authentication
  def authenticate_with_otp_two_factor
    user = self.resource = find_user

    if user_params[:otp_attempt].present? && session[:otp_user_id]
      authenticate_user_with_otp_two_factor(user)
    elsif user&.valid_password?(user_params[:password])
      prompt_for_otp_two_factor(user)
    end
  end

  private

  # Check if code or backup code is releated to current user
  def valid_otp_attempt?(user)
    user.validate_and_consume_otp!(user_params[:otp_attempt]) ||
        user.invalidate_otp_backup_code!(user_params[:otp_attempt])
  end

  # Display view for OTP
  def prompt_for_otp_two_factor(user)
    @user = user
    session[:otp_user_id] = user.id
    render 'devise/sessions/two_factor'
  end

  # Authenticate user with OTP
  def authenticate_user_with_otp_two_factor(user)
    if valid_otp_attempt?(user)
      # Remove any lingering user data from login
      session.delete(:otp_user_id)
      user.failed_attempts = 0
      remember_me(user) if user_params[:remember_me] == '1'
      user.save!
      sign_in(user, event: :authentication)
    else
      if user.failed_attempts > 3
        redirect_to root_url
      else
        user.update(failed_attempts: user.failed_attempts + 1)
        flash.now[:alert] = t('two_factor_settings.flash_messages.incorrect_otp')
        prompt_for_otp_two_factor(user)
      end
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :otp_attempt)
  end

  # Find user by otp_user_id or email to proceed otp auth
  def find_user
    if session[:otp_user_id]
      User.find(session[:otp_user_id])
    elsif user_params[:email]
      User.find_by(email: user_params[:email])
    end
  end

  # Is OTP required for current user
  def otp_two_factor_enabled?
    find_user&.otp_required_for_login
  end

end
