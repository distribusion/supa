module Supa
  module Commands
    class Append < Supa::Command
      def represent
        return @tree[@name] = nil unless processed_value || hide?
        return if hide?

        @tree[@name] ||= []

        Array(processed_value).each do |element|
          @tree[@name] << {}

          Supa::Builder.new(element, representer: @representer, tree: @tree[@name][-1]).instance_exec(&@block)
        end
      end

      private

      def value
        dynamic_value
      end

      def not_nil_value
        return [] if value.nil?
        value
      end

      def hide?
        return hide_when_empty? if value.nil?
        return false unless value.is_a?(Array)

        not_nil_value.any? ? false : hide_when_empty?
      end
    end
  end
end
