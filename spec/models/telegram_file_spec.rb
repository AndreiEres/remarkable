# frozen_string_literal: true

require "rails_helper"

describe TelegramFile do
  describe "#link" do
    it "returns file link" do
      bot = instance_double("Telegram::Bot::Client")
      file = described_class.new(bot: bot, file_id: "file_id")

      allow(bot).to receive(:token).and_return("_123")
      allow(file).to receive(:file).and_return(file_response)

      expect(file.link).to eq "https://api.telegram.org/file/bot_123/photos/file_5.jpg"
    end
  end

  private

  def file_response
    {
      "ok" => true,
      "result" => {
        "file_id" => "AgACAgIAAxkBAA",
        "file_unique_id" => "AQAD7tIRmC4AA7W4AgAB",
        "file_size" => 86_536,
        "file_path" => "photos/file_5.jpg"
      }
    }
  end
end
