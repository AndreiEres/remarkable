# frozen_string_literal: true

require "rails_helper"

describe TelegramMessageTodoText do
  describe "#text" do
    let(:bot) { OpenStruct.new(username: "test_bot") }

    let(:mention_message) do
      {
        "text" => "@test_bot \nNew todo for mention",
        "entities" => [{ "type" => "mention" }]
      }
    end

    let(:mention_with_photo_message) do
      {
        "photo" => [{ "file_id" => "AgACAgIAAx" }],
        "caption" => "@test_bot \nNew todo for mention with photo",
        "caption_entities" => [{ "type" => "mention" }]
      }
    end

    let(:reply_message) do
      {
        "reply_to_message" => {
          "text" => "New todo for reply"
        },
        "text" => "@test_bot",
        "entities" => [{ "type" => "mention" }]
      }
    end

    let(:reply_with_photo_message) do
      {
        "reply_to_message" => {
          "photo" => [{ "file_id" => "AgACAgIAAxk" }],
          "caption" => "New todo for reply with photo"
        },
        "text" => "@test_bot",
        "entities" => [{ "type" => "mention" }]
      }
    end

    it "returns todo text for mention" do
      todo_text = described_class.new(bot: bot, message: mention_message, message_type: :mention)

      expect(todo_text.text).to eq "New todo for mention"
    end

    it "returns todo text for mention with photo" do
      todo_text = described_class.new(bot: bot, message: mention_with_photo_message, message_type: :mention_with_photo)

      expect(todo_text.text).to eq "New todo for mention with photo"
    end

    it "returns todo text for reply" do
      todo_text = described_class.new(bot: bot, message: reply_message, message_type: :reply)

      expect(todo_text.text).to eq "New todo for reply"
    end

    it "returns todo text for reply with photo" do
      todo_text = described_class.new(bot: bot, message: reply_with_photo_message, message_type: :reply_with_photo)

      expect(todo_text.text).to eq "New todo for reply with photo"
    end
  end
end
