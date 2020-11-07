# frozen_string_literal: true

require "rails_helper"

describe TelegramMessageType do
  describe "#type" do
    let(:bot) { OpenStruct.new(username: "test_bot") }

    let(:mention_message) do
      {
        "text" => "@test_bot \nNew todo",
        "entities" => [{ "type" => "mention" }]
      }
    end

    let(:mention_with_photo_message) do
      {
        "photo" => [{ "file_id" => "AgACAgIAAx" }],
        "caption" => "@test_bot \nNew todo",
        "caption_entities" => [{ "type" => "mention" }]
      }
    end

    let(:reply_message) do
      {
        "reply_to_message" => {
          "text" => "New todo in reply"
        },
        "text" => "@test_bot",
        "entities" => [{ "type" => "mention" }]
      }
    end

    let(:reply_with_photo_message) do
      {
        "reply_to_message" => {
          "photo" => [{ "file_id" => "AgACAgIAAxk" }],
          "caption" => "New todo"
        },
        "text" => "@test_bot",
        "entities" => [{ "type" => "mention" }]
      }
    end

    it "returns :mention for mention message" do
      type = described_class.new(bot: bot, message: mention_message)

      expect(type.type).to be :mention
    end

    it "returns :mention_with_photo for mention message" do
      type = described_class.new(bot: bot, message: mention_with_photo_message)

      expect(type.type).to be :mention_with_photo
    end

    it "returns :reply for mention message" do
      type = described_class.new(bot: bot, message: reply_message)

      expect(type.type).to be :reply
    end

    it "returns :reply_with_photo for mention message" do
      type = described_class.new(bot: bot, message: reply_with_photo_message)

      expect(type.type).to be :reply_with_photo
    end

    it "returns nil for other messages" do
      type = described_class.new(bot: bot, message: {})

      expect(type.type).to be nil
    end
  end
end
