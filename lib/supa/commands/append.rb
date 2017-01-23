require 'supa/command'

module Supa
  module Commands
    class Append < Supa::Command
      def represent
        return unless value

        tree[name] ||= [] if render_collection?

        Array(processed_value).each do |element|
          tree[name] << {}

          Supa::Builder.new(representer: representer, context: element, tree: tree[name][-1]).instance_exec(&block)
        end
      end

      private

      def value
        dynamic_value
      end
    end
  end
end
