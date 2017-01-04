module Supa
  module Commands
    class Namespace < Supa::Command
      def represent
        @tree[@name] = {}

        Supa::Builder.new(@object, tree: @tree[@name], representer: @representer).instance_exec(&@block)
      end
    end
  end
end
