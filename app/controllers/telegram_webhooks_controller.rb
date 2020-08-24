# frozen_string_literal: true

class TelegramWebhooksController < Telegram::Bot::UpdatesController
  rescue_from Telegram::Bot::Error, with: :handle_error

  def message(message)
    telegram_message = TelegramMessage.new(message)
    todo = telegram_message.parse_todo

    reply_to_todo if todo.present?
  end

  def link!(*)
    reply_with_todolist_url
  end

  private

  def reply_to_todo
    reply_with :message, text: "Ok"
  end

  def reply_with_todolist_url
    todolist = Todolist.by_telegram_chat_id(chat["id"])
    text = todolist ? "Todos for #{chat['title']}\n#{todolist.url}" : "Create a todo first"

    reply_with :message, text: text
  end

  def handle_error(exception)
    respond_with :message, text: "Sorry, there was an error:\n>> #{exception}"
  end
end
