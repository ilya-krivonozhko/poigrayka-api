# frozen_string_literal: true

module Sortable
  extend ActiveSupport::Concern

  included do
    class_attribute :sortable_fields, instance_accessor: false, default: []
    class_attribute :default_sort, instance_accessor: false, default: nil
    default_scope { extending RelationMethods }
  end
  class_methods do
    def sortable_fields=(*fields)
      super(fields.flatten.map(&:to_s))
    end

    def default_sort=(value)
      super(value&.to_s)
    end
  end

  module RelationMethods
    def apply_sort(sort_param = nil)
      SortService.new(
        self,
        sort_param,
        allowed_fields: klass.sortable_fields,
        default: klass.default_sort
      ).call
    end
  end
end
