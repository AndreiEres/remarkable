# frozen_string_literal: true

require "rails_helper"

describe "Lists", "GET /show" do
  it "returns http success" do
    list = create(:list)
    get "/lists/#{list.slug}"

    expect(response).to have_http_status(:success)
  end
end
