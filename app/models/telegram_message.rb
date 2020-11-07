# frozen_string_literal: true

class TelegramMessage
  def initialize(message:, bot:)
    @message = structurize(message)
    @bot = bot
  end

  def parse_todo
    todo if todolike?
  end

  private

  attr_reader :message, :bot

  def bot_name_regexp
    @bot_name_regexp ||= "@#{bot.username}"
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
      sanitarize message_text
    end
  end

  def todo
    todo = Todo.new(text: text, todolist: todolist)

    if photo?
      file = TelegramFile.new(bot: bot, file_id: message.photo[-1].file_id)
      todo.attach_image_by_link(file.link)
    end

    todo.save
  end

  def list_key
    "telegram_#{chat_params.id}"
  end

  def todolist
    Todolist.find_by(key: list_key) || Todolist.create(**list_params)
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

  def todolike?
    bot_mention?
  end

  def bot_mention?
    message_type == "mention" && message_text.match?(bot_name_regexp)
  end

  def message_type
    if photo?
      message.caption_entities&.first&.type
    else
      message.entities&.first&.type
    end
  end

  def message_text
    if photo?
      message.caption
    else
      message.text
    end
  end

  def reply?
    message.reply_to_message.present?
  end

  def photo?
    message.photo.present?
  end
end
