module Supa
  module Commands
    module Collectionable
      private

      def collection
        collection = value
        collection.is_a?(Array) ? collection : [collection]
      end
    end
  end
end
