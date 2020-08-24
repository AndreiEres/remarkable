# frozen_string_literal: true

class RenameListsToTodolists < ActiveRecord::Migration[6.0]
  def change
    rename_table :lists, :todolists
  end
end
