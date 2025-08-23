# frozen_string_literal: true

class Admin::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])

    if user&.valid_password?(params[:user][:password])
      if user.otp_required_for_login?
        # Store user ID in session and show 2FA form
        session[:awaiting_2fa_user_id] = user.id

        # Render the two-factor verification form so the user can enter their OTP
        redirect_to admin_two_factor_path
      else
        # Normal login
        super
      end
    else
      super
    end
  end

  def two_factor
    if session[:awaiting_2fa_user_id]
    else
      redirect_to new_admin_user_session_path, alert: "Please sign in first."
    end
  end

  def two_factor_verify
    user = User.find(session[:awaiting_2fa_user_id])

    if user.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(user)
      session.delete(:awaiting_2fa_user_id)
      redirect_to after_sign_in_path_for(user), notice: "Signed in successfully!"
    else
      redirect_to new_user_session_path, alert: "Invalid verification code"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    admin_root_path
  end

  def after_sign_out_path_for(resource)
    admin_root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
