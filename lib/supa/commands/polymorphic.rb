module Supa
  module Commands
    class Polymorphic < Supa::Command
      include Supa::Commands::Collectionable

      def represent
        @tree[@name] ||= []

        collection.each do |element|
          @tree[@name] << {}

          Supa::Builder.new(element, tree: @tree[@name][-1], representer: @representer).instance_exec(&@block)
        end
      end
    end
  end
end
