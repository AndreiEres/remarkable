# frozen_string_literal: true

require "rails_helper"

describe TelegramMessage do
  describe "#parse_todo" do
    context "when todolist exist" do
      it "does NOT create new todolist" do
        telegram_message = described_class.new({})

        allow(telegram_message).to receive(:todolike?).and_return(false)
        allow(Todolist).to receive(:create)

        telegram_message.parse_todo

        expect(Todolist).not_to have_received(:create)
      end
    end

    context "when todolist does NOT exist" do
      it "creates todolist entity" do
        telegram_message = described_class.new(bot_mention)

        allow(Todolist).to receive(:create)
          .with(key: "telegram_10000", source: "telegram", title: "New Meeting",
                inner_title: "New Meeting", inner_id: "10000", inner_type: "group")

        telegram_message.parse_todo

        expect(Todolist).to have_received(:create)
      end
    end

    it "creates todo entity for bot mention" do
      telegram_message = described_class.new(bot_mention)
      todolist = instance_double(Todolist)

      allow(Todolist).to receive(:find_by).and_return(todolist)
      allow(Todo).to receive(:create).with(text: "New todo", todolist: todolist).and_return(true)

      todo = telegram_message.parse_todo

      expect(todo.present?).to be true
    end

    it "does NOT create todo entity for another mention" do
      telegram_message = described_class.new(another_mention)
      todolist = instance_double(Todolist)

      allow(Todolist).to receive(:find_by).and_return(todolist)

      todo = telegram_message.parse_todo

      expect(todo.present?).to be false
    end

    it "creates todo entity for mention in reply" do
      telegram_message = described_class.new(bot_reply)
      todolist = instance_double(Todolist)

      allow(Todolist).to receive(:find_by).and_return(todolist)
      allow(Todo).to receive(:create).with(text: "New todo in reply", todolist: todolist).and_return(true)

      todo = telegram_message.parse_todo

      expect(todo.present?).to be true
    end

    it "does NOT create todo for another mentions" do
      telegram_message = described_class.new(another_reply)
      todolist = instance_double(Todolist)

      allow(Todolist).to receive(:find_by).and_return(todolist)

      todo = telegram_message.parse_todo

      expect(todo.present?).to be false
    end

    private

    def bot_mention
      { "chat": { "id": 10_000,
                  "title": "New Meeting",
                  "type": "group",
                  "all_members_are_administrators": true },
        "date": 1_593_543_868,
        "text": "@yet_another_remarkable_bot \nNew todo",
        "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
    end

    def another_mention
      { "chat": { "id": 10_000,
                  "title": "New Meeting",
                  "type": "group",
                  "all_members_are_administrators": true },
        "date": 1_593_543_868,
        "text": "@hey \nNew todo",
        "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
    end

    def bot_reply
      { "message_id": 39,
        "from": { "id": 97_253_230,
                  "is_bot": false,
                  "first_name": "Andrei",
                  "last_name": "Eres",
                  "username": "AndreiEres",
                  "language_code": "en" },
        "chat": { "id": -433_657_644,
                  "title": "Test",
                  "type": "group",
                  "all_members_are_administrators": true },
        "date": 1_593_544_072,
        "reply_to_message": { "message_id": 34,
                              "from": { "id": 97_253_230,
                                        "is_bot": false,
                                        "first_name": "Andrei",
                                        "last_name": "Eres",
                                        "username": "AndreiEres",
                                        "language_code": "en" },
                              "chat": { "id": -433_657_644,
                                        "title": "Test",
                                        "type": "group",
                                        "all_members_are_administrators": true },
                              "date": 1_593_543_806,
                              "text": "New todo in reply" },
        "text": "@yet_another_remarkable_bot",
        "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
    end

    def another_reply
      { "message_id": 6,
        "from": { "id": 97_253_230,
                  "is_bot": false,
                  "first_name": "Andrei",
                  "last_name": "Eres",
                  "username": "AndreiEres" },
        "chat": { "id": -433_657_644,
                  "title": "Dev Remarkable Bot",
                  "type": "group",
                  "all_members_are_administrators": true },
        "date": 1_593_932_341,
        "reply_to_message": { "message_id": 4,
                              "from": { "id": 875_040_491,
                                        "is_bot": false,
                                        "first_name": "Eres",
                                        "last_name": "Marina" },
                              "chat": { "id": -433_657_644,
                                        "title": "Dev Remarkable Bot",
                                        "type": "group",
                                        "all_members_are_administrators": true },
                              "date": 1_593_932_316,
                              "text": "111" },
        "text": "1" }
    end
  end
end
