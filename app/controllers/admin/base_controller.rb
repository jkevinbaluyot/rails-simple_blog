module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :configure_permitted_parameters, if: :devise_controller?

    private
    def configure_permitted_parameters
      # For account update
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
  end
end
