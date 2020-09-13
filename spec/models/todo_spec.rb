# frozen_string_literal: true

require "rails_helper"

describe Todo do
  describe "associations" do
    it { is_expected.to have_many :comments }
  end

  describe "#status" do
    it "has status `do` on create" do
      todo = create(:todo, todolist: create(:todolist))

      expect(todo.do?).to be true
    end
  end
end
