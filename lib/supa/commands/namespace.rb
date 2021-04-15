module Supa
  module Commands
    class Namespace < Supa::Command
      def represent
        return if hide?

        @tree[@name] = {}
        return if value.nil? && empty_when_nil?

        Supa::Builder.new(@subject, representer: @representer, tree: @tree[@name]).instance_exec(&@block)
      end

      private

      def hide?
        (value.nil? || value.empty?) && hide_when_empty?
      end
    end
  end
end
