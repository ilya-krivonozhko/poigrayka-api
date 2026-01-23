# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[8.0]
  def change # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    create_table :products do |t|
      t.string :title, null: false, limit: 80
      t.integer :stock, null: false
      t.text :description, null: false
      t.string :short_description, null: false, limit: 150
      t.text :rules, null: false
      t.text :contents, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.integer :min_players, null: false
      t.integer :max_players, null: false
      t.integer :age_rating, null: false
      t.integer :play_time, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, 'lower(title)', name: 'index_products_on_lower_title'
    add_index :products, :price
    add_check_constraint :products, 'stock >= 0', name: 'stock_non_negative'
    add_check_constraint :products, 'price >= 0', name: 'price_non_negative'
    add_check_constraint :products, 'price < 10000000', name: 'price_upper_bound'
    add_check_constraint :products, 'play_time > 0', name: 'play_time_positive'
    add_check_constraint :products, 'age_rating >= 0', name: 'age_rating_non_negative'
    add_check_constraint :products, 'min_players > 0', name: 'min_players_positive'
    add_check_constraint :products, 'max_players > 0 AND max_players <= 100', name: 'max_players_range'
    add_check_constraint :products, 'min_players <= max_players', name: 'players_range_valid'
  end
end
