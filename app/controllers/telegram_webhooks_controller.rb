# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  rescue_from Telegram::Bot::Error, with: :handle_error

  def message(message)
    telegram_message = TelegramMessage.new(message)
    task = telegram_message.parse_task

    reply_to_task if task.present?
  end

  def link!(*)
    reply_with_list_url
  end

  def list!(*)
    reply_with_list_url
  end

  private

  def reply_to_task
    reply_with :message, text: "Ok"
  end

  def reply_with_list_url
    list = List.by_telegram_chat_id(chat["id"])
    text = list ? "Tasks for #{chat['title']}\n#{list.url}" : "Create a task first"

    reply_with :message, text: text
  end

  def handle_error(exception)
    respond_with :message, text: "Sorry, there was an error:\n>> #{exception}"
  end
end
