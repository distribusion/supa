module Supa
  module Commands
    class Object < Supa::Command
      def represent
        return @tree[@name] = nil unless processed_value || hide_when_empty?
        return if hide_when_empty?

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
        return '' if value.nil?
        value
      end
    end
  end
end
