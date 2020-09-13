# frozen_string_literal: true

require "rails_helper"

describe Comment do
  describe "associations" do
    it { is_expected.to belong_to :todo }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:todo) }
  end
end
