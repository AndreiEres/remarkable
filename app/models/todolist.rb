# frozen_string_literal: true

class Todolist < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :todos, dependent: :destroy

  validates :key, presence: true, uniqueness: true
  before_validation :generate_slug

  def self.by_telegram_chat_id(id)
    find_by(inner_id: id)
  end

  def self.find_or_create_from_telegram_message(telegram_message)
    create_with(telegram_message.todolist_params)
      .find_or_create_by(key: telegram_message.todolist_key)
  end

  def url
    url_for(self)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= Nanoid.generate
  end
end
