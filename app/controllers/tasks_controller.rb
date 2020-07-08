# frozen_string_literal: true

class TasksController < ApplicationController
  def update
    task = Task.find(params[:id])
    task.status = params[:status]
    task.save

    redirect_to list_path(task.list)
  end

  def destroy
    task = Task.find(params[:id])
    list = task.list
    task.destroy

    redirect_to list_path(list)
  end
end
