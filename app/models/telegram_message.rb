# frozen_string_literal: true

class TelegramMessage
  def initialize(bot:, message:)
    @bot = bot
    @message = message
    @message_type = TelegramMessageType.new(bot: bot, message: message).type
  end

  def todolike?
    message_type.present?
  end

  def text
    TelegramMessageTodoText.new(bot: bot, message: message, message_type: message_type).text
  end

  def photo_link
    TelegramMessageTodoPhotoLink.new(bot: bot, message: message, message_type: message_type).photo_link
  end

  def todolist_key
    id = message.dig("chat", "title")

    "telegram_#{id}"
  end

  def todolist_params
    {
      source: "telegram",
      title: message.dig("chat", "title"),
      inner_title: message.dig("chat", "title"),
      inner_id: message.dig("chat", "id").to_s,
      inner_type: message.dig("chat", "type")
    }
  end

  private

  attr_reader :bot, :message, :message_type
end
