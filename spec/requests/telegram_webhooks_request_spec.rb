# frozen_string_literal: true

require "rails_helper"
require "telegram/bot/rspec/integration/rails"

describe "TelegramWebhooks", telegram_bot: :rails do
  describe "message" do
    let(:telegram_message) { instance_double(TelegramMessage) }

    let(:todo) { instance_double(Todo) }

    let(:message) do
      {
        "message": {
          "text": "Hello!",
          "chat": { "id": 1 }
        }
      }
    end

    let(:todolike_message) do
      {
        "message": {
          "text": "@test_bot \nNew todo",
          "chat": { "id": 1 },
          "entities": [{ "type": "mention" }]
        }
      }
    end

    before { allow(TelegramMessage).to receive(:new).and_return(telegram_message) }

    it "does NOT answer for messages" do
      allow(telegram_message).to receive(:todolike?).and_return(false)

      expect { dispatch(message) }.not_to send_telegram_message(bot, "Ok")
    end

    it "answers `Ok` for todo" do
      allow(telegram_message).to receive(:todolike?).and_return(true)
      allow(Todo).to receive(:create_from_telegram_message).and_return(true)

      expect { dispatch(todolike_message) }.to send_telegram_message(bot, "Ok")
    end
  end

  describe "#link!" do
    it "sends link to todos" do
      todolist = instance_double(Todolist)
      chat_title = ""

      allow(Todolist).to receive(:by_telegram_chat_id).and_return(todolist)
      allow(todolist).to receive(:url).and_return("todolist_url")

      expect { dispatch_command(:link) }.to send_telegram_message(bot, "Todos for #{chat_title}\ntodolist_url")
    end
  end
end
