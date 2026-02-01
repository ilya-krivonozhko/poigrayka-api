# frozen_string_literal: true

module Api
  module Paginatable
    extend ActiveSupport::Concern
    include Pagy::Method

    included do
      class_attribute :default_per_page, instance_accessor: false, default: 9
    end

    private

    def paginate(scope)
      lim_param = params[:limit].to_i
      pg_param = params[:page]

      return [nil, scope] if pg_param.to_s.downcase == 'all'

      limit = lim_param.positive? ? lim_param : self.class.default_per_page
      page  = pg_param.to_i.positive? ? pg_param.to_i : 1

      pagy(scope, page: page, limit: limit)
    end
  end
end
