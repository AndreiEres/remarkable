# frozen_string_literal: true

class AddSlugToTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :slug, :string
    add_index :todos, :slug, unique: true

    reversible do |dir|
      dir.up do
        Todo.all.each do |todo|
          todo.generate_slug
          todo.save
        end
      end
    end
  end
end
