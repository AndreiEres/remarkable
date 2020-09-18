# frozen_string_literal: true

class TodolistsController < ApplicationController
  def show
    @todolist = Todolist.find_by!(slug: params[:id])
    @statuses = Todo.statuses.keys
    @grouped_todos = @todolist.todos.order(:id).group_by(&:status)
  end
end
