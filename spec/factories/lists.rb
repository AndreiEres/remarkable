# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    sequence(:key) { |n| "source_#{n}@example.com" }
    sequence(:title) { |n| "My List #{n}" }
    sequence(:inner_title) { |n| "My List #{n}" }
    sequence(:inner_id, &:to_s)
    source { "source" }
    inner_type { "group" }
  end
end
