# frozen_string_literal: true

class RenameListIdInTodos < ActiveRecord::Migration[6.0]
  def change
    rename_column :todos, :list_id, :todolist_id
  end
end
