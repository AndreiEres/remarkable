# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :todo

  validates :todo, presence: true

  has_rich_text :content
end
