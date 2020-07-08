# frozen_string_literal: true

require "rails_helper"

describe "User deletes task" do
  let(:list) { create(:list) }

  before do
    driven_by(:rack_test)

    create(:task, text: "My task to delete", list: list)
    create(:task, text: "My other task", list: list)
  end

  it "deletes task" do
    visit list_path(list)

    click_on "Delete", match: :first

    expect(page).not_to have_css ".task", text: "My task to delete"
  end

  it "sees other tasks" do
    visit list_path(list)

    click_on "Delete", match: :first

    expect(page).to have_css ".task", text: "My other task"
  end
end
