module Supa
  module Commands
    class Object < Supa::Command
      def represent

        if !processed_value && !hide_when_empty?
          return @tree[@name] = nil
        end

        if hide_when_empty?
          return
        end

        @tree[@name] = {}

        if @subject
          Supa::Builder.new(processed_value, representer: @representer, tree: @tree[@name])
                       .instance_exec(&@block)
        end
      end

      private

      def value
        dynamic_value
      end

      def convert_to_empty_object(object)
          return '' if object.nil?
          object
      end
    end
  end
end
