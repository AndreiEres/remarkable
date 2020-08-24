# frozen_string_literal: true

require "rails_helper"

describe Todo do
  describe "#status" do
    it "has status `do` on create" do
      todo = create(:todo, todolist: create(:todolist))

      expect(todo.do?).to be true
    end
  end
end
