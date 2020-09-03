# frozen_string_literal: true

class TodosController < ApplicationController
  def show
    @todo = Todo.find_by!(slug: params[:id])
  end

  def update
    todo = Todo.find(params[:id])
    todo.status = params[:status]
    todo.save

    redirect_to todolist_path(todo.todolist)
  end

  def destroy
    todo = Todo.find(params[:id])
    todolist = todo.todolist
    todo.destroy

    redirect_to todolist_path(todolist)
  end
end
