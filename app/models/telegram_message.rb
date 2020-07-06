# frozen_string_literal: true

class TelegramMessage
  def initialize(message)
    @message = structurize(message)
  end

  def parse_task
    task if taskable?
  end

  private

  attr_reader :message

  def bot_name_regexp
    @bot_name_regexp ||= "@#{Telegram.bot.username}"
  end

  def structurize(message)
    JSON.parse(message.to_json, object_class: OpenStruct)
  end

  def sanitarize(text)
    text
      .gsub(bot_name_regexp, "")
      .squish
  end

  def text
    if reply?
      reply_params.text
    else
      sanitarize message.text
    end
  end

  def task
    Task.create(text: text, list: list)
  end

  def list_key
    "telegram_#{chat_params.id}"
  end

  def list
    List.find_by(key: list_key) || List.create(**list_params)
  end

  def reply_params
    message.reply_to_message
  end

  def chat_params
    @chat_params ||= message.chat
  end

  def list_params
    { key: "telegram_#{chat_params.id}",
      source: "telegram",
      title: chat_params.title,
      inner_title: chat_params.title,
      inner_id: chat_params.id.to_s,
      inner_type: chat_params.type }
  end

  def taskable?
    bot_mention?
  end

  def bot_mention?
    message.entities&.first&.type == "mention" &&
      message.text.match?(bot_name_regexp)
  end

  def reply?
    message.reply_to_message.present?
  end
end
