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
    it "finds or creates todolist from telegram message" do
      allow(described_class).to receive(:create_with).with({}).and_return(described_class)
      allow(described_class).to receive(:find_or_create_by).with(key: "key").and_return(true)

      message = instance_double(TelegramMessage, todolist_key: "key", todolist_params: {})
      described_class.find_or_create_from_telegram_message(message)

      expect(described_class).to have_received(:find_or_create_by)
    end
  end

  describe "#url" do
    it "returns todolist's url" do
      todolist = create(:todolist, slug: "slug")

      expect(todolist.url).to eq("http://localhost:3000/todolists/slug")
    end
  end
end
