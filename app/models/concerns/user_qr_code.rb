# app/models/concerns/user_qr_code.rb
module UserQrCode
  extend ActiveSupport::Concern

  def enable_two_factor!
    update!(
      otp_secret: ROTP::Base32.random,
      otp_required_for_login: true
    )
    generate_backup_codes!
  end

  def validate_and_consume_otp!(code)
    if valid_otp?(code)
      consume_otp!(code)
      true
    else
      false
    end
  end

  def consume_otp!(code)
    clean_code = code.to_s.gsub(/\s+/, "").upcase

    # Check if it's a backup code
    if otp_backup_codes&.include?(clean_code)
      # Remove backup code
      update!(otp_backup_codes: otp_backup_codes - [ clean_code ])
      true
    end
  end

  def valid_otp?(code)
    # Clean the code (remove spaces, etc.)
    clean_code = code.to_s.gsub(/\s+/, "").upcase

    # Check backup codes first
    return true if otp_backup_codes&.include?(clean_code)

    # Check if we have a secret
    unless otp_secret.present?
      Rails.logger.error "No OTP secret found for user #{id}"
      return false
    end

    # Verify TOTP code
    totp = ROTP::TOTP.new(otp_secret)
    result = totp.verify(clean_code, drift_behind: 30, drift_ahead: 30)

    if result
      Rails.logger.info "Valid TOTP code accepted for user #{id}"
      true
    else
      Rails.logger.warn "Invalid TOTP code attempted for user #{id}: #{clean_code}"
      false
    end
  end

  def generate_backup_codes!
    codes = Array.new(10) { SecureRandom.hex(4).upcase }
    update!(otp_backup_codes: codes)
    codes
  end

  def two_factor_qr_code
    return unless otp_secret.present?

    issuer = "YourApp"
    label = "#{issuer}:#{email}"
    uri = ROTP::TOTP.new(otp_secret, issuer: issuer).provisioning_uri(label)

    RQRCode::QRCode.new(uri).as_svg(module_size: 4)
  end

  def disable_two_factor!
    update!(
      otp_secret: nil,
      otp_required_for_login: false,
      otp_backup_codes: []
    )
  end
end
