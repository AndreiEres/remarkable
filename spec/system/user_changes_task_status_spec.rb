# frozen_string_literal: true

require "rails_helper"

describe "User changes todo status", type: :system do
  let(:todolist) { create(:todolist) }

  before do
    driven_by(:rack_test)
  end

  def visit_todolist(todolist)
    visit todolist_path(todolist)
  end

  def change_first_todo_status(status)
    click_on status.to_s.titleize, match: :first
  end

  def have_todo_with_status(text:, status:)
    have_css ".status__#{status} .todo-text", text: text
  end

  it "sees created todos on do section" do
    create(:todo, text: "My todo", todolist: todolist)

    visit_todolist todolist

    expect(page).to have_todo_with_status text: "My todo", status: :do
  end

  it "changes status to done" do
    create(:todo, text: "My todo to done", todolist: todolist)

    visit_todolist todolist
    change_first_todo_status :done

    expect(page).to have_todo_with_status text: "My todo to done", status: :done
  end

  it "changes status to later" do
    create(:todo, text: "My todo to later", todolist: todolist)

    visit_todolist todolist
    change_first_todo_status :later

    expect(page).to have_todo_with_status text: "My todo to later", status: :later
  end

  it "changes status to never" do
    create(:todo, text: "My todo to never", todolist: todolist)

    visit_todolist todolist
    change_first_todo_status :never

    expect(page).to have_todo_with_status text: "My todo to never", status: :never
  end

  it "sees only do control for status done" do
    create(:todo, text: "My todo to never", status: :done, todolist: todolist)

    visit_todolist todolist

    expect(page).not_to have_css ".todo-controls", text: "Done Later Never"
  end
end
