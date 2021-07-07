require "application_system_test_case"

class ItemsTest < ApplicationSystemTestCase
  setup do
    @item = items(:one)
  end

  test "visiting the index" do
    visit items_url
    assert_selector "h1", text: "Items"
  end

  test "creating a Item" do
    visit items_url
    click_on "New Item"

    fill_in "Comment", with: @item.comment
    fill_in "Count", with: @item.count
    fill_in "Date", with: @item.date
    fill_in "Image", with: @item.image_id
    fill_in "Name", with: @item.name
    fill_in "Send", with: @item.send
    fill_in "Standard", with: @item.standard
    click_on "Create Item"

    assert_text "Item was successfully created"
    click_on "Back"
  end

  test "updating a Item" do
    visit items_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @item.comment
    fill_in "Count", with: @item.count
    fill_in "Date", with: @item.date
    fill_in "Image", with: @item.image_id
    fill_in "Name", with: @item.name
    fill_in "Send", with: @item.send
    fill_in "Standard", with: @item.standard
    click_on "Update Item"

    assert_text "Item was successfully updated"
    click_on "Back"
  end

  test "destroying a Item" do
    visit items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Item was successfully destroyed"
  end
end