# frozen_string_literal: true

class TasksController < ApplicationController
  def destroy
    task = Task.find(params[:id])
    list = task.list
    task.destroy

    redirect_to list_path(list)
  end
end
