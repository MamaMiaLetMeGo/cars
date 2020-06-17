require "application_system_test_case"

class TransmissionsTest < ApplicationSystemTestCase
  setup do
    @transmission = transmissions(:one)
  end

  test "visiting the index" do
    visit transmissions_url
    assert_selector "h1", text: "Transmissions"
  end

  test "creating a Transmission" do
    visit transmissions_url
    click_on "New Transmission"

    fill_in "Transmission", with: @transmission.transmission
    click_on "Create Transmission"

    assert_text "Transmission was successfully created"
    click_on "Back"
  end

  test "updating a Transmission" do
    visit transmissions_url
    click_on "Edit", match: :first

    fill_in "Transmission", with: @transmission.transmission
    click_on "Update Transmission"

    assert_text "Transmission was successfully updated"
    click_on "Back"
  end

  test "destroying a Transmission" do
    visit transmissions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Transmission was successfully destroyed"
  end
end
