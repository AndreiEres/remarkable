# frozen_string_literal: true

class List < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :key, presence: true, uniqueness: true

  def to_param
    slug
  end

  before_validation :generate_slug

  def generate_slug
    self.slug ||= Nanoid.generate
  end
end
