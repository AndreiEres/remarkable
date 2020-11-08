# frozen_string_literal: true

require "open-uri"

class Todo < ApplicationRecord
  enum status: { do: 0, done: 1, later: 2, never: 3 }

  belongs_to :todolist

  before_validation :generate_slug

  has_one_attached :image

  def self.create_from_telegram_message(bot:, message:)
    telegram_message = TelegramMessage.new(bot: bot, message: message)

    return nil unless telegram_message.todolike?

    text = telegram_message.text
    photo_link = telegram_message.photo_link
    todolist = Todolist.find_or_create_from_telegram_message(telegram_message)
    todo = new(text: text, todolist: todolist)

    todo.attach_image_by_link(photo_link) if photo_link

    todo.save
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= Nanoid.generate
  end

  def attach_image_by_link(link)
    downloaded_image = URI.parse(link).open
    image.attach(io: downloaded_image, filename: "image.jpg")
  end
end
