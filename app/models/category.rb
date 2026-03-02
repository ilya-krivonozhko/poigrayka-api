# frozen_string_literal: true

class Category < ApplicationRecord
  include Sortable

  self.sortable_fields = :title, :created_at
  self.default_sort = :title

  has_many :products, dependent: :destroy

  validates :title,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 50 }
end
