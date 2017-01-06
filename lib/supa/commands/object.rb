module Supa
  module Commands
    class Object < Supa::Command
      def represent
        @tree[@name] = {}

        Supa::Builder.new(value, tree: @tree[@name], representer: @representer).instance_exec(&@block)
      end
    end
  end
end
