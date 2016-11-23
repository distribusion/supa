require 'securerandom'

module Supa
  module Sequence
    class << self
      def word(size)
        ('a'..'z').to_a.sample(size).join.capitalize
      end

      def id
        SecureRandom.uuid
      end
    end
  end
end
