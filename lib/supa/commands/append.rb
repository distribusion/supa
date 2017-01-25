module Supa
  module Commands
    class Append < Supa::Command
      def represent
        return @tree[@name] = nil unless value || hide?
        return if hide?

        @tree[@name] ||= []

        Array(value).each do |element|
          @tree[@name] << {}

          Supa::Builder.new(element, representer: @representer, tree: @tree[@name][-1]).instance_exec(&@block)
        end
      end

      private

      def flagged_value(raw_value)
        return [] if !raw_value && empty_when_nil?
        raw_value
      end

      def hide?
        return hide_when_empty? unless value
        return false unless value.is_a?(Array)

        value.any? ? false : hide_when_empty?
      end
    end
  end
end
