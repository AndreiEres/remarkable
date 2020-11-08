# frozen_string_literal: true

class TelegramMessageTodoPhotoLink
  def initialize(bot:, message:, message_type:)
    @bot = bot
    @message = message
    @message_type = message_type
  end

  def photo_link
    send "#{message_type}_photo_link".to_sym
  end

  private

  attr_reader :bot, :message, :message_type

  def mention_photo_link
    nil
  end

  def mention_with_photo_photo_link
    link message.dig("photo", 0, "file_id")
  end

  def reply_photo_link
    nil
  end

  def reply_with_photo_photo_link
    link message.dig("reply_to_message", "photo", 0, "file_id")
  end

  def link(file_id)
    TelegramFile.new(bot: bot, file_id: file_id).link
  end
end
