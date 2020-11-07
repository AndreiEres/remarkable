# frozen_string_literal: true

class TelegramMessageType
  def initialize(bot:, message:)
    @bot = bot
    @message = message
  end

  def type
    return :mention if mention?
    return :mention_with_photo if mention_with_photo?
    return :reply if reply?
    return :reply_with_photo if reply_with_photo?
  end

  private

  attr_reader :bot, :message

  def mention?
    !message["reply_to_message"] &&
      message.dig("entities", 0, "type") == "mention" &&
      message["text"].match?("@#{bot.username}")
  end

  def mention_with_photo?
    message["photo"] &&
      message.dig("caption_entities", 0, "type") == "mention" &&
      message["caption"].match?("@#{bot.username}")
  end

  def reply?
    message["reply_to_message"] &&
      !message.dig("reply_to_message", "photo") &&
      message.dig("entities", 0, "type") == "mention" &&
      message["text"].match?("@#{bot.username}")
  end

  def reply_with_photo?
    message.dig("reply_to_message", "photo") &&
      message.dig("entities", 0, "type") == "mention" &&
      message["text"].match?("@#{bot.username}")
  end
end
