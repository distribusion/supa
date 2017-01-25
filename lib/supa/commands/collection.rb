module Supa
  module Commands
    class Collection < Supa::Command
      def represent
        return @tree[@name] = nil unless processed_value || hide?
        return if hide?

        @tree[@name] = []

        Array(processed_value).each do |element|
          @tree[@name] << {}

          Supa::Builder.new(element, representer: @representer, tree: @tree[@name][-1]).instance_exec(&@block)
        end
      end

      private

      def value
        return [] if !dynamic_value && empty_when_nil?
        dynamic_value
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Array)

        value.any? ? false : hide_when_empty?
      end
    end
  end
end
