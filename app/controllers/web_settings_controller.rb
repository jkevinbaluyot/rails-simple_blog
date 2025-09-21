class WebSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_web_setting, only: %i[ show edit update destroy ]

  # GET /web_settings or /web_settings.json
  def index; end

  # GET /web_settings/1 or /web_settings/1.json
  def show; end

  # GET /web_settings/new
  def new
    @web_setting = WebSetting.new
  end

  # GET /web_settings/1/edit
  def edit
  end

  # POST /web_settings or /web_settings.json
  def create
    @web_setting = WebSetting.new(web_setting_params)

    respond_to do |format|
      if @web_setting.save
        format.html { redirect_to @web_setting, notice: "Web setting was successfully created." }
        format.json { render :show, status: :created, location: @web_setting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @web_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /web_settings/1 or /web_settings/1.json
  def update
    respond_to do |format|
      if @web_setting.update(web_setting_params)
        format.html { redirect_to admin_root_path, notice: "Web setting was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @web_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /web_settings/1 or /web_settings/1.json
  def destroy
    @web_setting.destroy!

    respond_to do |format|
      format.html { redirect_to web_settings_path, notice: "Web setting was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_setting
      @web_setting = WebSetting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def web_setting_params
      params.require(:web_setting).permit(:site_name)
    end
end
