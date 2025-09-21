class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_web_setting

  private

  def set_web_setting
    @web_setting = WebSetting.first
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid
    @web_setting = nil
  end
end
