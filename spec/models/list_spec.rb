# frozen_string_literal: true

require "rails_helper"

describe List do
  describe ".create" do
    it "has own slug" do
      list = create(:list)

      expect(list.slug.present?).to be true
    end
  end
end
