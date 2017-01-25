module Supa
  module Commands
    class Append < Commands::Collection
      def define_tree
        @tree[@name] ||= !value ? nil : []
      end
    end
  end
end
