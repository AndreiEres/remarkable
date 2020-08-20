# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  rescue_from Telegram::Bot::Error, with: no_method

  def message(message)
    telegram_message = TelegramMessage.new(message)
    task = telegram_message.parse_task

    reply_to_task if task.present?
  end

  def link!(*)
    reply_with_list_url
  end

  private

  def reply_to_task
    reply_with :message, text: "Ok" if reply_message_exist?
  end

  def reply_with_list_url
    list = List.by_telegram_chat_id(chat["id"])
    text = list ? "Tasks for #{chat['title']}\n#{list.url}" : "Create a task first"

    reply_with :message, text: text if reply_message_exist?
  end

  def reply_message_exist?
    payload && payload["message_id"]
  end

  def no_method
    respond_with :message, text: "Sorry, there was an error, but I don't know what to do with it"
  end
end
