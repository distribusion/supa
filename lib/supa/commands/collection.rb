module Supa
  module Commands
    class Collection < Supa::Command
      def represent
        return if hide?

        define_tree
        return if !value

        value.each do |element|
          @tree[@name] << {}

          Supa::Builder.new(element,
            representer: @representer, tree: @tree[@name][-1]
          ).instance_exec(&@block)
        end
      end

      private

      def apply_render_flags(val)
        return [] if !val && empty_when_nil?
        val
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Array)

        value.any? ? false : hide_when_empty?
      end

      def define_tree
        @tree[@name] = !value ? nil : []
      end
    end
  end
end
