# frozen_string_literal: true

class List < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :tasks, dependent: :destroy

  validates :key, presence: true, uniqueness: true
  before_validation :generate_slug

  scope :by_telegram_chat_id, ->(id) { find_by(inner_id: id) }

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
