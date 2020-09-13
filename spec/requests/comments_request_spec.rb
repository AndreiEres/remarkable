# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Comments", type: :request do
  describe "POST /" do
    let(:todo) { create(:todo, todolist: build(:todolist)) }
    let(:params) { { comment: { todo_id: todo.id, content: "Hello" } } }

    it "creates a comment" do
      expect { post "/comments/", params: params }.to change(Comment, :count).by(1)
    end

    it "redirects to todo" do
      post "/comments/", params: params

      expect(response).to redirect_to(todo)
    end
  end
end
