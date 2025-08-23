  # frozen_string_literal: true

  class Admin::HomeController < Admin::BaseController
    before_action :authenticate_user!
    # GET /admin or GET /admin/home

    def index
      # TODO: implement admin dashboard
      render :index
    end
  end
