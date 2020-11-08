# frozen_string_literal: true

require "rails_helper"

describe Todolist do
  describe ".create" do
    it "has own slug" do
      todolist = create(:todolist)

      expect(todolist.slug.present?).to be true
    end
  end

  describe ".by_telegram_chat_id" do
    context "when todolist exist" do
      it "finds todolist by telegram chat id" do
        todolist = create(:todolist, inner_id: "telegram_chat_id")

        expect(described_class.by_telegram_chat_id("telegram_chat_id")).to eq todolist
      end
    end

    context "when todolist does NOT exist" do
      it "returns nil" do
        expect(described_class.by_telegram_chat_id("another_chat_id")).to be nil
      end
    end
  end

  describe ".find_or_create_from_telegram_message" do
    xit "finds or creates todolist from telegram message"
  end

  describe "#url" do
    it "returns todolist's url" do
      todolist = create(:todolist, slug: "slug")

      expect(todolist.url).to eq("http://localhost:3000/todolists/slug")
    end
  end
end
