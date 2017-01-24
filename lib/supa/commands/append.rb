module Supa
  module Commands
    class Append < Supa::Command
      def represent
        if !processed_value && !hide_when_empty?
          return @tree[@name] = nil
        end

        # if hide_when_nil?
        #   return
        # end

        if hide_when_empty?
          return
        end

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

      def convert_to_empty_object(object)
        return [] if object.nil?
        object
      end
    end
  end
end
