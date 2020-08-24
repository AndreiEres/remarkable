# frozen_string_literal: true

require "rails_helper"

describe "Todolists" do
  describe "GET /show" do
    it "returns http success" do
      todolist = create(:todolist)
      get "/todolists/#{todolist.slug}"

      expect(response).to have_http_status(:success)
    end
  end
end
