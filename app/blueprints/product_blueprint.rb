# frozen_string_literal: true

class ProductBlueprint < Blueprinter::Base
  identifier :id

  view :basic do
    fields  :title,
            :stock,
            :price,
            :min_players,
            :max_players,
            :age_rating,
            :play_time
    association :category, blueprint: CategoryBlueprint
  end

  # View for displaying multiple products on a catalog page
  view :normal do
    include_view :basic
    field :short_description
  end

  # Detailed product view used for a single product page
  view :extended do
    include_view :basic
    fields  :description,
            :rules,
            :contents
  end

  # Complete view for admin panel
  view :full do
    include_view :basic
    fields  :created_at,
            :updated_at,
            :description,
            :short_description,
            :rules,
            :contents
  end
end
