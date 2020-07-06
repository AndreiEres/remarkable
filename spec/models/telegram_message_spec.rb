# frozen_string_literal: true

require "rails_helper"

describe TelegramMessage, "#parse_task" do
  context "when list exist" do
    it "does NOT create new list" do
      telegram_message = described_class.new({})

      allow(telegram_message).to receive(:taskable?).and_return(false)
      allow(List).to receive(:create)

      telegram_message.parse_task

      expect(List).not_to have_received(:create)
    end
  end

  context "when list does NOT exist" do
    it "creates list entity" do # rubocop:disable RSpec/ExampleLength
      telegram_message = described_class.new(bot_mention)

      allow(List).to receive(:create)
        .with(key: "telegram_10000", source: "telegram", title: "New Meeting",
              inner_title: "New Meeting", inner_id: "10000", inner_type: "group")

      telegram_message.parse_task

      expect(List).to have_received(:create)
    end
  end

  it "creates task entity for bot mention" do # rubocop:disable RSpec/ExampleLength
    telegram_message = described_class.new(bot_mention)
    list = instance_double(List)

    allow(List).to receive(:find_by).and_return(list)
    allow(Task).to receive(:create).with(text: "New task", list: list).and_return(true)

    task = telegram_message.parse_task

    expect(task.present?).to be true
  end

  it "does NOT create task entity for another mention" do
    telegram_message = described_class.new(another_mention)
    list = instance_double(List)

    allow(List).to receive(:find_by).and_return(list)

    task = telegram_message.parse_task

    expect(task.present?).to be false
  end

  it "creates task entity for mention in reply" do # rubocop:disable RSpec/ExampleLength
    telegram_message = described_class.new(bot_reply)
    list = instance_double(List)

    allow(List).to receive(:find_by).and_return(list)
    allow(Task).to receive(:create).with(text: "New task in reply", list: list).and_return(true)

    task = telegram_message.parse_task

    expect(task.present?).to be true
  end

  it "does NOT create task for another mentions" do
    telegram_message = described_class.new(another_reply)
    list = instance_double(List)

    allow(List).to receive(:find_by).and_return(list)

    task = telegram_message.parse_task

    expect(task.present?).to be false
  end

  private

  def bot_mention
    { "chat": { "id": 10_000,
                "title": "New Meeting",
                "type": "group",
                "all_members_are_administrators": true },
      "date": 1_593_543_868,
      "text": "@yet_another_remarkable_bot \nNew task",
      "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
  end

  def another_mention
    { "chat": { "id": 10_000,
                "title": "New Meeting",
                "type": "group",
                "all_members_are_administrators": true },
      "date": 1_593_543_868,
      "text": "@hey \nNew task",
      "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
  end

  def bot_reply # rubocop:disable Metrics/MethodLength
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
                            "text": "New task in reply" },
      "text": "@yet_another_remarkable_bot",
      "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
  end

  def another_reply # rubocop:disable Metrics/MethodLength
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
