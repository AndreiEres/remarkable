# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    todo = Todo.find(comment_params[:todo_id])
    todo.comments.create!(content: comment_params[:content])

    redirect_to todo
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:content, :todo_id)
  end
end
