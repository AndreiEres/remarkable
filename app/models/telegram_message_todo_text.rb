# frozen_string_literal: true

class TelegramMessageTodoText
  def initialize(bot:, message:, message_type:)
    @bot = bot
    @message = message
    @message_type = message_type
  end

  def text
    send "#{message_type}_text".to_sym
  end

  private

  attr_reader :bot, :message, :message_type

  def mention_text
    clean_up_text message["text"]
  end

  def mention_with_photo_text
    clean_up_text message["caption"]
  end

  def reply_text
    clean_up_text message.dig("reply_to_message", "text")
  end

  def reply_with_photo_text
    clean_up_text message.dig("reply_to_message", "caption")
  end

  def clean_up_text(text)
    (text || "")
      .gsub("@#{bot.username}", "")
      .squish
  end
end
