# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      include Api::Paginatable

      before_action :set_category, only: %i[show update destroy]

      def index
        _pagy, categories = paginate Category.all
        render json: CategoryBlueprint.render(categories), status: :ok
      end

      def show
        render json: CategoryBlueprint.render(@category), status: :ok
      end

      def create
        category = Category.create!(category_params)
        render json: CategoryBlueprint.render(category), status: :created
      end

      def update
        @category.update!(category_params)
        render json: CategoryBlueprint.render(@category), status: :ok
      end

      def destroy
        @category.destroy
        head :no_content
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.expect(category: [:title])
      end
    end
  end
end
