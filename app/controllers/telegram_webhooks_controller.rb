# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    @message = message

    return unless mention? || reply?

    create_list
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

  def create_list
    List.create(
      key: "telegram_#{@message['chat']['id']}",
      source: "telegram",
      title: @message["chat"]["title"],
      inner_title: @message["chat"]["title"],
      inner_id: @message["chat"]["id"].to_s,
      inner_type: @message["chat"]["type"]
    )
  end
end
