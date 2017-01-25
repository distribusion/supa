module Supa
  module Commands
    class Object < Supa::Command
      def represent
        return @tree[@name] = nil unless processed_value || hide?
        return if hide?

        @tree[@name] = {}

        Supa::Builder.new(
          processed_value,
          representer: @representer,
          tree: @tree[@name]
        ).instance_exec(&@block)
      end

      private

      def value
        dynamic_value
      end

      def not_nil_value
        return {} if value.nil?
        value
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Hash)

        value.empty? ? hide_when_empty? : false
      end
    end
  end
end
