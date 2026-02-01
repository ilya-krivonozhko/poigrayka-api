# frozen_string_literal: true

module Api
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    end

    private

    # TODO(i18n): add translation
    def render_not_found
      render json: {
        error: {
          code: 'record_not_found',
          message: 'Resource not found'
        }
      }, status: :not_found
    end

    def render_unprocessable_entity(exception)
      render json: {
        error: {
          code: 'validation_failed',
          details: exception.record.errors.to_hash(true)
        }
      }, status: :unprocessable_entity # rubocop:disable Rails/HttpStatusNameConsistency
    end
  end
end
