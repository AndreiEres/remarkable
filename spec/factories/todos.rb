# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    text { "MyText" }
    todolist { nil }
  end
end
