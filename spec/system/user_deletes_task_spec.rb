# frozen_string_literal: true

require "rails_helper"

describe "User deletes task", type: :system do
  let(:todolist) { create(:todolist) }

  before do
    driven_by(:rack_test)

    create(:todo, text: "My todo to delete", todolist: todolist)
    create(:todo, text: "My other todo", todolist: todolist)
  end

  it "deletes todo" do
    visit todolist_path(todolist)

    click_on "Delete", match: :first

    expect(page).not_to have_css ".todo", text: "My todo to delete"
  end

  it "sees other tasks" do
    visit todolist_path(todolist)

    click_on "Delete", match: :first

    expect(page).to have_css ".todo", text: "My other todo"
  end
end
