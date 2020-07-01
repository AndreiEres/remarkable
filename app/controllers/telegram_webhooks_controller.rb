# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def message(message)
    telegram_message = TelegramMessage.new(message)
    task = telegram_message.parse_task

    reply_to_task if task.present?
  end

  private

  def reply_to_task
    reply_with :message, text: "Ok"
  end
end
