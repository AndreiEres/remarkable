# frozen_string_literal: true

class TelegramMessageTodoPhotoLink
  def initialize(bot:, message:, message_type:)
    @bot = bot
    @message = message
    @message_type = message_type
  end

  def photo_link
    send "photo_link_for_#{message_type}".to_sym
  end

  private

  attr_reader :bot, :message, :message_type

  def photo_link_for_mention
    nil
  end

  def photo_link_for_mention_with_photo
    link message.dig("photo", -1, "file_id")
  end

  def photo_link_for_reply
    nil
  end

  def photo_link_for_reply_with_photo
    link message.dig("reply_to_message", "photo", -1, "file_id")
  end

  def link(file_id)
    TelegramFile.new(bot: bot, file_id: file_id).link
  end
end
