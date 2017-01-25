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

      def apply_render_flags(val)
        return {} if !val && empty_when_nil?
        val
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Hash)

        value.empty? ? hide_when_empty? : false
      end
    end
  end
end
