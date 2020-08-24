# frozen_string_literal: true

require "rails_helper"

describe "User changes todo status", type: :system do
  let(:todolist) { create(:todolist) }

  before do
    driven_by(:rack_test)
  end

  it "sees no badge on status do" do
    create(:todo, text: "My todo", todolist: todolist)

    visit todolist_path(todolist)

    expect(page).not_to have_css ".todo-text", text: "Do My todo"
  end

  it "changes status to done" do
    create(:todo, text: "My todo to done", todolist: todolist)

    visit todolist_path(todolist)

    click_on "Done", match: :first

    expect(page).to have_css ".todo-text", text: "Done My todo to done"
  end

  it "changes status to later" do
    create(:todo, text: "My todo to later", todolist: todolist)

    visit todolist_path(todolist)

    click_on "Later", match: :first

    expect(page).to have_css ".todo-text", text: "Later My todo to later"
  end

  it "changes status to never" do
    create(:todo, text: "My todo to never", todolist: todolist)

    visit todolist_path(todolist)

    click_on "Never", match: :first

    expect(page).to have_css ".todo-text", text: "Never My todo to never"
  end

  it "sees only do control for status done" do
    create(:todo, text: "My todo to never", status: :done, todolist: todolist)

    visit todolist_path(todolist)

    expect(page).not_to have_css ".todo-controls", text: "Done Later Never"
  end
end
