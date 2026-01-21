# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[show update destroy]

      def index
        categories = Category.all
        render json: categories.as_json(
          only: %i[id title created_at updated_at]
        ), status: :ok
      end

      def show
        render json: @category.as_json(
          only: %i[id title created_at updated_at]
        ), status: :ok
      end

      def create
        category = Category.create!(category_params)
        render json: category.as_json(
          only: %i[id title created_at updated_at]
        ), status: :created
      end

      def update
        @category.update!(category_params)
        render json: @category.as_json(
          only: %i[id title created_at updated_at]
        ), status: :ok
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
