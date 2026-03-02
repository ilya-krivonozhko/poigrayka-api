# frozen_string_literal: true

class SortService < ApplicationService
  def initialize(scope, sort_param, allowed_fields:, default: nil) # rubocop:disable Lint/MissingSuper
    @scope = scope
    @sort_param = sort_param
    @allowed_fields = allowed_fields.map(&:to_s)
    @default = default
  end

  def call
    param = normalize_sort_param(@sort_param)
    param = @default if param.blank? && @default.present?
    return @scope if param.blank?

    parse_sort_param(param.to_s).each do |field, direction|
      @scope = @scope.order(field => direction)
    end

    @scope
  end

  private

  def normalize_sort_param(param)
    case param
    when String
      param.strip
    when Array
      param.join(',')
    else
      param.to_s.strip
    end
  end

  def parse_sort_param(param)
    param.split(',').filter_map do |pair|
      field, dir = pair.split(':', 2).map(&:strip)
      next unless @allowed_fields.include?(field)

      direction = dir&.downcase == 'desc' ? :desc : :asc
      [field, direction]
    end
  end
end
