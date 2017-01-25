module Supa
  module Commands
    class Attribute < Supa::Command
      def represent
        @tree[@name] = value
      end
    end
  end
end
