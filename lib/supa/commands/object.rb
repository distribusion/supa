module Supa
  module Commands
    class Object < Supa::Command
      def represent
        return @tree[@name] = nil unless value || hide?
        return if hide?

        @tree[@name] = {}

        Supa::Builder.new(
          value,
          representer: @representer,
          tree: @tree[@name]
        ).instance_exec(&@block)
      end

      private

      def flagged_value(raw_value)
        return {} if !raw_value && empty_when_nil?
        raw_value
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Hash)

        value.empty? ? hide_when_empty? : false
      end
    end
  end
end
