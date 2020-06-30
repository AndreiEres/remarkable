# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    @message = message

    return unless mention? || reply?

    reply_with :message, text: "Ok"
  end

  private

  def mention?
    entities = @message["entities"] || [{}]
    entities.first["type"] == "mention"
  end

  def reply?
    @message["reply_to_message"].present?
  end
end
