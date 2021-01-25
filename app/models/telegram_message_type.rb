# frozen_string_literal: true

class TelegramMessageType
  def initialize(bot:, message:)
    @bot = bot
    @message = message
  end

  def type
    return :reply if reply?
    return :mention if mention?
    return :reply_with_photo if reply_with_photo?
    return :mention_with_photo if mention_with_photo?
  end

  private

  attr_reader :bot, :message

  def reply?
    message["reply_to_message"] &&
      !message.dig("reply_to_message", "photo") &&
      entities_include_mention? &&
      bot_called?
  end

  def mention?
    !message["reply_to_message"] &&
      entities_include_mention? &&
      bot_called?
  end

  def reply_with_photo?
    message.dig("reply_to_message", "photo") &&
      entities_include_mention? &&
      bot_called?
  end

  def mention_with_photo?
    message["photo"] &&
      entities_include_mention?(path: "caption_entities") &&
      bot_called?(path: "caption")
  end

  def bot_called?(path: "text")
    message[path].match?("@#{bot.username}")
  end

  def entities_include_mention?(path: "entities")
    message.dig(path, 0, "type") == "mention"
  end
end
