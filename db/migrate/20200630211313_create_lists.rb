# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[6.0]
  def change
    create_table :lists do |t|
      t.string :source
      t.string :title
      t.string :inner_title
      t.string :inner_id
      t.string :inner_type

      t.timestamps
    end
  end
end
