# frozen_string_literal: true

require "rails_helper"

describe "User visits a todolist", type: :system do
  let(:todolist) { create(:todolist, title: "My First Todolist") }

  before do
    driven_by(:rack_test)
  end

  it "sees a todolist title" do
    visit todolist_path(todolist)

    expect(page).to have_css "h1", text: "My First Todolist"
  end

  it "sees tasks" do
    create(:todo, text: "My todo", todolist: todolist)

    visit todolist_path(todolist)

    expect(page).to have_css "li", text: "My todo"
  end

  it "sees formatted links" do
    create(:todo, text: "My todo for https://example.com", todolist: todolist)

    visit todolist_path(todolist)

    expect(page).to have_css "a", text: "https://example.com"
  end
end
