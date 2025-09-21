require "application_system_test_case"

class WebSettingsTest < ApplicationSystemTestCase
  setup do
    @web_setting = web_settings(:one)
  end

  test "visiting the index" do
    visit web_settings_url
    assert_selector "h1", text: "Web settings"
  end

  test "should create web setting" do
    visit web_settings_url
    click_on "New web setting"

    fill_in "Site name", with: @web_setting.site_name
    click_on "Create Web setting"

    assert_text "Web setting was successfully created"
    click_on "Back"
  end

  test "should update Web setting" do
    visit web_setting_url(@web_setting)
    click_on "Edit this web setting", match: :first

    fill_in "Site name", with: @web_setting.site_name
    click_on "Update Web setting"

    assert_text "Web setting was successfully updated"
    click_on "Back"
  end

  test "should destroy Web setting" do
    visit web_setting_url(@web_setting)
    click_on "Destroy this web setting", match: :first

    assert_text "Web setting was successfully destroyed"
  end
end
