# frozen_string_literal: true

class RenameTasksToTodos < ActiveRecord::Migration[6.0]
  def change
    rename_table :tasks, :todos
  end
end
