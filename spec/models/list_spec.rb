# frozen_string_literal: true

require "rails_helper"

describe List, ".create" do
  it "has own slug" do
    list = create(:list)

    expect(list.slug.present?).to be true
  end
end

describe List, ".by_telegram_chat_id" do
  context "when list exist" do
    it "finds list by telegram chat id" do
      list = create(:list, inner_id: "telegram_chat_id")

      expect(described_class.by_telegram_chat_id("telegram_chat_id")).to eq list
    end
  end

  context "when list does NOT exist" do
    it "returns nil" do
      expect(described_class.by_telegram_chat_id("another_chat_id")).to be nil
    end
  end
end

describe List, "#url" do
  it "returns list's url" do
    list = create(:list, slug: "slug")

    expect(list.url).to eq("http://localhost:3000/lists/slug")
  end
end
