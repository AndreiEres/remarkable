# frozen_string_literal: true

require "rails_helper"

describe "User visits a list" do
  before do
    driven_by(:rack_test)
  end

  it "sees a list title" do
    list = create(:list, title: "My First List")

    visit list_path(list)

    expect(page).to have_css "h1", text: "My First List"
  end

  it "sees tasks" do
    list = create(:list, title: "My First List")
    create(:task, text: "My Task", list: list)

    visit list_path(list)

    expect(page).to have_css "li", text: "My Task"
  end
end
