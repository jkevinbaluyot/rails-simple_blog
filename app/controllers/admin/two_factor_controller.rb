# app/controllers/two_factor_controller.rb
class Admin::TwoFactorController < Admin::BaseController
  before_action :authenticate_user!

  def create
    current_user.enable_two_factor!
    flash[:notice] = "2FA enabled! Scan the QR code."

    respond_to do |format|
      format.html { redirect_to admin_edit_registration_path }
      format.turbo_stream
    end
  end

  def regenerate_backup_codes
    @backup_codes = current_user.generate_backup_codes!
    flash[:notice] = "New backup codes generated."

    respond_to do |format|
      format.html { redirect_to admin_edit_registration_path }
      format.turbo_stream
    end
  end

  def destroy
    current_user.disable_two_factor!
    redirect_to admin_edit_registration_path, notice: "2FA disabled."
  end
end
