# frozen_string_literal: true

class List < ApplicationRecord
  validates :key, presence: true, uniqueness: true

  before_validation :generate_slug

  def generate_slug
    self.slug ||= Nanoid.generate
  end
end
