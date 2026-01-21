# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 50 }
end
