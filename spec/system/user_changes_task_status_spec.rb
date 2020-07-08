# frozen_string_literal: true

require "rails_helper"

describe "User changes task status" do
  let(:list) { create(:list) }

  before do
    driven_by(:rack_test)
  end

  it "sees no badge on status do" do
    create(:task, text: "My task", list: list)

    visit list_path(list)

    expect(page).not_to have_css ".task-text", text: "Do My task"
  end

  it "changes status to done" do
    create(:task, text: "My task to done", list: list)

    visit list_path(list)

    click_on "Done", match: :first

    expect(page).to have_css ".task-text", text: "Done My task to done"
  end

  it "changes status to later" do
    create(:task, text: "My task to later", list: list)

    visit list_path(list)

    click_on "Later", match: :first

    expect(page).to have_css ".task-text", text: "Later My task to later"
  end

  it "changes status to never" do
    create(:task, text: "My task to never", list: list)

    visit list_path(list)

    click_on "Never", match: :first

    expect(page).to have_css ".task-text", text: "Never My task to never"
  end

  it "sees only do control for status done" do
    create(:task, text: "My task to never", status: :done, list: list)

    visit list_path(list)

    expect(page).not_to have_css ".task-controls", text: "Done Later Never"
  end
end
