# frozen_string_literal: true

class RenameListIndexInTodos < ActiveRecord::Migration[6.0]
  def change
    rename_index :todos, "index_todos_on_list_id", "index_todos_on_todolist_id"
  end
end
