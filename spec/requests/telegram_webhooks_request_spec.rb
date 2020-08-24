# frozen_string_literal: true

require "rails_helper"
require "telegram/bot/rspec/integration/rails"

MESSAGE = {
  "update_id": 479_705_436,
  "message": {
    "message_id": 35,
    "from": {
      "id": 97_253_230,
      "is_bot": false,
      "first_name": "Andrei",
      "last_name": "Eres",
      "username": "AndreiEres",
      "language_code": "en"
    },
    "chat": {
      "id": -433_657_644,
      "title": "Test",
      "type": "group",
      "all_members_are_administrators": true
    },
    "date": 1_593_543_839,
    "text": "Hello!"
  }
}.freeze

BOT_MENTION = {
  "update_id": 479_705_437,
  "message": {
    "message_id": 37,
    "from": {
      "id": 97_253_230,
      "is_bot": false,
      "first_name": "Andrei",
      "last_name": "Eres",
      "username": "AndreiEres",
      "language_code": "en"
    },
    "chat": {
      "id": 10_000,
      "title": "New Meeting",
      "type": "group",
      "all_members_are_administrators": true
    },
    "date": 1_593_543_868,
    "text": "@yet_another_remarkable_bot \nNew todo",
    "entities": [{ "offset": 0, "length": 27, "type": "mention" }]
  }
}.freeze

ANOTHER_MENTION = {
  "update_id": 479_705_437,
  "message": {
    "message_id": 37,
    "from": {
      "id": 97_253_230,
      "is_bot": false,
      "first_name": "Andrei",
      "last_name": "Eres",
      "username": "AndreiEres",
      "language_code": "en"
    },
    "chat": {
      "id": 10_000,
      "title": "New Meeting",
      "type": "group",
      "all_members_are_administrators": true
    },
    "date": 1_593_543_868,
    "text": "@hey \nNew todo",
    "entities": [{ "offset": 0, "length": 27, "type": "mention" }]
  }
}.freeze

BOT_REPLY = {
  "update_id": 479_705_438,
  "message": {
    "message_id": 39,
    "from": {
      "id": 97_253_230,
      "is_bot": false,
      "first_name": "Andrei",
      "last_name": "Eres",
      "username": "AndreiEres",
      "language_code": "en"
    },
    "chat": {
      "id": -433_657_644,
      "title": "Test",
      "type": "group",
      "all_members_are_administrators": true
    },
    "date": 1_593_544_072,
    "reply_to_message": {
      "message_id": 34,
      "from": {
        "id": 97_253_230,
        "is_bot": false,
        "first_name": "Andrei",
        "last_name": "Eres",
        "username": "AndreiEres",
        "language_code": "en"
      },
      "chat": {
        "id": -433_657_644,
        "title": "Test",
        "type": "group",
        "all_members_are_administrators": true
      },
      "date": 1_593_543_806,
      "text": "1111"
    },
    "text": "@yet_another_remarkable_bot",
    "entities": [{ "offset": 0, "length": 27, "type": "mention" }]
  }
}.freeze

ANOTHER_REPLY = {
  "update_id": 512_583_965,
  "message": {
    "message_id": 6,
    "from": {
      "id": 97_253_230,
      "is_bot": false,
      "first_name": "Andrei",
      "last_name": "Eres",
      "username": "AndreiEres"
    },
    "chat": {
      "id": -433_657_644,
      "title": "Dev Remarkable Bot",
      "type": "group",
      "all_members_are_administrators": true
    },
    "date": 1_593_932_341,
    "reply_to_message": {
      "message_id": 4,
      "from": {
        "id": 875_040_491,
        "is_bot": false,
        "first_name": "Eres",
        "last_name": "Marina"
      },
      "chat": {
        "id": -433_657_644,
        "title": "Dev Remarkable Bot",
        "type": "group",
        "all_members_are_administrators": true
      },
      "date": 1_593_932_316,
      "text": "111"
    },
    "text": "1"
  }
}.freeze

describe "TelegramWebhooks", telegram_bot: :rails do
  describe "message" do
    let(:telegram_message) { instance_double(TelegramMessage) }
    let(:todo) { instance_double(Todo) }

    before { allow(TelegramMessage).to receive(:new).and_return(telegram_message) }

    it "does NOT answer for messages" do
      allow(telegram_message).to receive(:parse_todo).and_return(nil)

      expect { dispatch(MESSAGE) }.not_to send_telegram_message(bot, "Ok")
    end

    it "answers `Ok` for bot mentions" do
      allow(telegram_message).to receive(:parse_todo).and_return(todo)

      expect { dispatch(BOT_MENTION) }.to send_telegram_message(bot, "Ok")
    end

    it "does NOT answer `Ok` for another mentions" do
      allow(telegram_message).to receive(:parse_todo).and_return(nil)

      expect { dispatch(ANOTHER_MENTION) }.not_to send_telegram_message(bot, "Ok")
    end

    it "answers `Ok` for bot replies" do
      allow(telegram_message).to receive(:parse_todo).and_return(todo)

      expect { dispatch(BOT_REPLY) }.to send_telegram_message(bot, "Ok")
    end

    it "does NOT answer for another replies" do
      allow(telegram_message).to receive(:parse_todo).and_return(nil)

      expect { dispatch(ANOTHER_REPLY) }.not_to send_telegram_message(bot, "Ok")
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
