require 'active_support/concern'
require 'administrate/default_order/version'

module Administrate
  module DefaultOrder
    extend ::ActiveSupport::Concern

    class_methods do
      def default_order(model, options)
        param = ::Kernel::String(model.try(:name) || model).underscore.to_sym

        order = extract_sort_by_from_options(options)

        before_action(options.without(:_order, :_direction, :order)) do
          if !params[param] || !params[param][:order]
            params[param] ||= {}
            params[param].merge!(order)
          end
        end
      end

      private

      def extract_sort_by_from_options(options)
        return { order: options, direction: :asc } unless options.is_a?(::Hash)

        if options[:order] && !%i[asc desc ASC DESC].include?(options[:order].to_sym)
          return { order: options[:order], direction: options[:direction] || :asc }
        end

        { order: options.keys.first, direction: options.values.first }
      end
    end
  end
end
