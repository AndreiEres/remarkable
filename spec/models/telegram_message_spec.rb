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
      telegram_message = described_class.new(mention)

      allow(List).to receive(:create)
        .with(key: "telegram_10000", source: "telegram", title: "New Meeting",
              inner_title: "New Meeting", inner_id: "10000", inner_type: "group")

      telegram_message.parse_task

      expect(List).to have_received(:create)
    end
  end

  it "creates task entity" do # rubocop:disable RSpec/ExampleLength
    telegram_message = described_class.new(mention)
    list = instance_double(List)

    allow(List).to receive(:find_by).and_return(list)
    allow(Task).to receive(:create).with(text: "New task", list: list).and_return(true)

    task = telegram_message.parse_task

    expect(task.present?).to be true
  end

  private

  def mention
    { "chat": { "id": 10_000,
                "title": "New Meeting",
                "type": "group",
                "all_members_are_administrators": true },
      "date": 1_593_543_868,
      "text": "@yet_another_remarkable_bot \nNew task",
      "entities": [{ "offset": 0, "length": 27, "type": "mention" }] }
  end
end
