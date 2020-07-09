# frozen_string_literal: true

require "rails_helper"

describe "User visits a list" do
  let(:list) { create(:list, title: "My First List") }

  before do
    driven_by(:rack_test)
  end

  it "sees a list title" do
    visit list_path(list)

    expect(page).to have_css "h1", text: "My First List"
  end

  it "sees tasks" do
    create(:task, text: "My Task", list: list)

    visit list_path(list)

    expect(page).to have_css "li", text: "My Task"
  end

  it "sees formatted links" do
    create(:task, text: "My Task for https://example.com", list: list)

    visit list_path(list)

    expect(page).to have_css "a", text: "https://example.com"
  end
end
