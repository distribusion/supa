module Supa
  module Commands
    class Namespace < Supa::Command
      def represent
        @tree[@name] = {}

        Supa::Builder.new(@subject, representer: @representer, tree: @tree[@name]).instance_exec(&@block)
      end
    end
  end
end
