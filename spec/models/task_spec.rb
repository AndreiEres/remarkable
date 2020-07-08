# frozen_string_literal: true

require "rails_helper"

describe Task, "#status" do
  it "has status `do` on create" do
    task = create(:task, list: create(:list))

    expect(task.do?).to be true
  end
end
