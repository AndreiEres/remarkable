# frozen_string_literal: true

class DropComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :comments do |t|
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
