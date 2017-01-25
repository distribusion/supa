module Supa
  module Commands
    class Append < Supa::Command
      def represent
        return @tree[@name] = nil unless processed_value || _hide_when_empty?
        return if _hide_when_empty?

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
    end
  end
end
