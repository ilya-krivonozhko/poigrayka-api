# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false, limit: 50

      t.timestamps
    end
    add_index :categories, 'lower(title)', unique: true, name: 'index_categories_on_lower_title'
  end
end
