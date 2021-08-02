require "application_system_test_case"

class PromptsTest < ApplicationSystemTestCase
  setup do
    @prompt = prompts(:one)
  end

  test "visiting the index" do
    visit prompts_url
    assert_selector "h1", text: "Prompts"
  end

  test "creating a Prompt" do
    visit prompts_url
    click_on "New Prompt"

    fill_in "Body", with: @prompt.body
    fill_in "Title", with: @prompt.title
    click_on "Create Prompt"

    assert_text "Prompt was successfully created"
    click_on "Back"
  end

  test "updating a Prompt" do
    visit prompts_url
    click_on "Edit", match: :first

    fill_in "Body", with: @prompt.body
    fill_in "Title", with: @prompt.title
    click_on "Update Prompt"

    assert_text "Prompt was successfully updated"
    click_on "Back"
  end

  test "destroying a Prompt" do
    visit prompts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Prompt was successfully destroyed"
  end
end
