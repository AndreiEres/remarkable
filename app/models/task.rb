# frozen_string_literal: true

class Task < ApplicationRecord
  enum status: { do: 0, done: 1, later: 2, never: 3 }
  belongs_to :list
end
