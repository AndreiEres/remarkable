# frozen_string_literal: true

class TelegramMessage
  def initialize(message)
    @message = OpenStruct.new(message)
  end

  def parse_task
    task if taskable?
  end

  private

  attr_reader :message

  def text
    message.text.gsub(/@yet_another_remarkable_bot/, "").squish
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

  def first_entity
    OpenStruct.new(message.entities&.first)
  end

  def chat_params
    @chat_params ||= OpenStruct.new(message.chat)
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
    mention? || reply?
  end

  def mention?
    first_entity.type == "mention"
  end

  def reply?
    message.reply_to_message.present?
  end
end
