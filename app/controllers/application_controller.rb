class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_web_setting

  layout :layout_by_resource

  private

  def set_web_setting
    @web_setting = WebSetting.first
  rescue ActiveRecord::NoDatabaseError, ActiveRecord::StatementInvalid
    @web_setting = nil
  end

  def  layout_by_resource
    if devise_controller?
      "admin"
    else
      "application"
    end
  end
end
