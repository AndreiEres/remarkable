# frozen_string_literal: true

require "rails_helper"

describe TelegramMessage do
  let(:bot) { instance_double("Telegram::Bot::Client") }
  let(:message_type) { instance_double(TelegramMessageType, type: :any_type) }

  before { allow(TelegramMessageType).to receive(:new).and_return(message_type) }

  describe "#todolike?" do
    context "when message type presents" do
      it "is todolike" do
        telegram_message = described_class.new(bot: bot, message: {})

        expect(telegram_message.todolike?).to be true
      end
    end

    context "when message has no type" do
      it "is todolike" do
        no_message_type = instance_double(TelegramMessageType, type: nil)
        allow(TelegramMessageType).to receive(:new).and_return(no_message_type)

        telegram_message = described_class.new(bot: bot, message: {})

        expect(telegram_message.todolike?).to be false
      end
    end
  end

  describe "text" do
    it "returns text" do
      todo_text = instance_double(TelegramMessageTodoText, text: "New todo")
      allow(TelegramMessageTodoText).to receive(:new).and_return(todo_text)

      telegram_message = described_class.new(bot: bot, message: {})

      expect(telegram_message.text).to be "New todo"
    end
  end

  describe "photo_link" do
    it "returns photo_link" do
      photo_link = instance_double(TelegramMessageTodoPhotoLink, photo_link: "https://...")
      allow(TelegramMessageTodoPhotoLink).to receive(:new).and_return(photo_link)

      telegram_message = described_class.new(bot: bot, message: {})

      expect(telegram_message.photo_link).to be "https://..."
    end
  end

  describe "todolist_key" do
    it "returns tofolist_key" do
      telegram_message = described_class.new(
        bot: bot,
        message: { "chat" => { "id" => -123 } }
      )

      expect(telegram_message.todolist_key).to eq "telegram_-123"
    end
  end

  describe "todolist_params" do
    it "returns todolist_params" do # rubocop:disable RSpec/ExampleLength
      telegram_message = described_class.new(
        bot: bot,
        message: { "chat" => { "id" => -123, "title" => "Chat title", "type" => "any_type" } }
      )

      expect(telegram_message.todolist_params).to eq(
        {
          source: "telegram",
          title: "Chat title",
          inner_title: "Chat title",
          inner_id: "-123",
          inner_type: "any_type"
        }
      )
    end
  end
end
