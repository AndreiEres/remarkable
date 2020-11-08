# frozen_string_literal: true

require "rails_helper"

describe TelegramMessageTodoPhotoLink do
  describe "#photo_link" do
    let(:bot) { OpenStruct.new(username: "test_bot") }
    let(:file) { instance_double(TelegramFile) }

    let(:mention_message) do
      {
        "text" => "@test_bot \nNew todo for mention",
        "entities" => [{ "type" => "mention" }]
      }
    end

    let(:mention_with_photo_message) do
      {
        "photo" => [{ "file_id" => "file_id_for_mention_with_photo" }],
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
          "photo" => [{ "file_id" => "file_id_for_reply_with_photo" }],
          "caption" => "New todo for reply with photo"
        },
        "text" => "@test_bot",
        "entities" => [{ "type" => "mention" }]
      }
    end

    it "returns nil for mention" do
      todo_text = described_class.new(bot: bot, message: mention_message, message_type: :mention)

      expect(todo_text.photo_link).to eq nil
    end

    it "returns link for mention with photo" do
      allow(TelegramFile).to receive(:new).with(bot: bot, file_id: "file_id_for_mention_with_photo").and_return(file)
      allow(file).to receive(:link).and_return("photo_link")

      todo_text = described_class.new(bot: bot, message: mention_with_photo_message, message_type: :mention_with_photo)

      expect(todo_text.photo_link).to eq "photo_link"
    end

    it "returns nil for reply" do
      todo_text = described_class.new(bot: bot, message: reply_message, message_type: :reply)

      expect(todo_text.photo_link).to eq nil
    end

    it "returns link for reply with photo" do
      allow(TelegramFile).to receive(:new).with(bot: bot, file_id: "file_id_for_reply_with_photo").and_return(file)
      allow(file).to receive(:link).and_return("photo_link")

      todo_text = described_class.new(bot: bot, message: reply_with_photo_message, message_type: :reply_with_photo)

      expect(todo_text.photo_link).to eq "photo_link"
    end
  end
end
