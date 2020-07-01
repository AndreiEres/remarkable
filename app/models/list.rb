# frozen_string_literal: true

class List < ApplicationRecord
  validates :key, presence: true, uniqueness: { case_sensitive: false }
end
