module Supa
  module Commands
    class Collection < Supa::Command
      def represent
        return unless value

        tree[name] = [] if render?

        Array(processed_value).each do |element|
          tree[name] << {}

          Supa::Builder.new(element, representer: representer, tree: tree[name][-1]).instance_exec(&block)
        end
      end

      private

      def value
        dynamic_value
      end
    end
  end
end
