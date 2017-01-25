module Supa
  module Commands
    class Virtual < Supa::Command
      def represent
        @tree[@name] = value
      end

      private

      def value
        modifier ? @representer.send(modifier, getter) : getter
      end
    end
  end
end
