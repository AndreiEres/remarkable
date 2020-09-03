# frozen_string_literal: true

require "rails_helper"

describe "Todos" do
  describe "GET /show" do
    it "returns http success" do
      todo = create(:todo, todolist: create(:todolist))
      get "/todos/#{todo.slug}"

      expect(response).to have_http_status(:success)
    end
  end
end
