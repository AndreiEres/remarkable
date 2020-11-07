# frozen_string_literal: true

require "open-uri"

class Todo < ApplicationRecord
  enum status: { do: 0, done: 1, later: 2, never: 3 }

  belongs_to :todolist

  before_validation :generate_slug

  has_one_attached :image

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
