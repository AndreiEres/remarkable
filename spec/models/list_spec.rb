# frozen_string_literal: true

require "rails_helper"

describe List, ".create" do
  it "has own slug" do
    list = create(:list)

    expect(list.slug.present?).to be true
  end
end

describe List, ".by_telegram_chat_id" do
  it "finds list by telegram chat id" do
    list = create(:list, inner_id: "telegram_chat_id")

    expect(described_class.by_telegram_chat_id("telegram_chat_id")).to eq list
  end
end

describe List, "#url" do
  it "returns list's url" do
    list = create(:list, slug: "slug")

    expect(list.url).to eq("http://localhost:3000/lists/slug")
  end
end
