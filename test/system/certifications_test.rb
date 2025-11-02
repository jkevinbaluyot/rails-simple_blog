require "application_system_test_case"

class CertificationsTest < ApplicationSystemTestCase
  setup do
    @certification = certifications(:one)
  end

  test "visiting the index" do
    visit certifications_url
    assert_selector "h1", text: "Certifications"
  end

  test "should create certification" do
    visit certifications_url
    click_on "New certification"

    check "Confirmed" if @certification.confirmed
    fill_in "Image url", with: @certification.image_url
    fill_in "Teacher", with: @certification.teacher
    fill_in "Title", with: @certification.title
    click_on "Create Certification"

    assert_text "Certification was successfully created"
    click_on "Back"
  end

  test "should update Certification" do
    visit certification_url(@certification)
    click_on "Edit this certification", match: :first

    check "Confirmed" if @certification.confirmed
    fill_in "Image url", with: @certification.image_url
    fill_in "Teacher", with: @certification.teacher
    fill_in "Title", with: @certification.title
    click_on "Update Certification"

    assert_text "Certification was successfully updated"
    click_on "Back"
  end

  test "should destroy Certification" do
    visit certification_url(@certification)
    click_on "Destroy this certification", match: :first

    assert_text "Certification was successfully destroyed"
  end
end
