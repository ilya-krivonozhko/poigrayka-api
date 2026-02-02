# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include Api::Paginatable

      before_action :set_product, only: %i[show update destroy]

      def index
        pagy, products = paginate Product.all
        render json: {
          data: ProductBlueprint.render_as_hash(products, view: :normal),
          meta: pagy&.data_hash
        }, status: :ok
      end

      def show
        render json: ProductBlueprint.render_as_hash(@product, view: :extended), status: :ok
      end

      def create
        @product = Product.create!(product_params)
        render json: ProductBlueprint.render_as_hash(@product, view: :extended), status: :created
      end

      def update
        @product.update!(product_params)
        render json: ProductBlueprint.render_as_hash(@product, view: :extended), status: :ok
      end

      def destroy
        @product.destroy
        head :no_content
      end

      private

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params # rubocop:disable Metrics/MethodLength
        params.expect(
          product: %i[title
                      stock
                      description
                      short_description
                      rules
                      contents
                      price
                      min_players
                      max_players
                      age_rating
                      play_time
                      category_id]
        )
      end
    end
  end
end
