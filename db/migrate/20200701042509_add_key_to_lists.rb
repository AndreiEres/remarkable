# frozen_string_literal: true

class AddKeyToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :key, :string
    add_index :lists, :key, unique: true
  end
end
