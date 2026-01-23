# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  validates :title,
            presence: true,
            length: { minimum: 2, maximum: 80 }

  validates :description, :short_description, :rules, :contents,
            presence: true,
            length: { minimum: 3 }

  validates :short_description,
            length: { maximum: 150 }

  validates :stock,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :price,
            presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than: 10_000_000 }

  validates :age_rating,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :play_time,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  validates :min_players,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  validates :max_players,
            presence: true,
            numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }

  validate :valid_players_range

  private

  def valid_players_range
    return unless min_players.present? && max_players.present? && min_players > max_players

    errors.add(:min_players, 'не может быть больше чем максимальное количество игроков')
  end
end
