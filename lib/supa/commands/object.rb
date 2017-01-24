module Supa
  module Commands
    class Object < Supa::Command
      def represent
        tree[name] = {} if render?

        if context
          Supa::Builder.new(processed_value, representer: representer, tree: tree[name])
                       .instance_exec(&block)
        end
      end

      private

      def value
        dynamic_value
      end
    end
  end
end
