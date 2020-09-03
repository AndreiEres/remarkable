# frozen_string_literal: true

class Todo < ApplicationRecord
  enum status: { do: 0, done: 1, later: 2, never: 3 }
  belongs_to :todolist

  before_validation :generate_slug

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= Nanoid.generate
  end
end
