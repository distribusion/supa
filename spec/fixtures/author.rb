module Supa
  class Author
    attr_accessor :id, :first_name, :last_name

    def initialize(id:, first_name:, last_name:)
      @id = id
      @first_name = first_name
      @last_name = last_name
    end

    def to_hash
      {id: id, first_name: first_name, last_name: last_name}
    end
  end

  module Fixtures
    def self.author
      Author.new(id: Supa::Sequence.id,
                 first_name: Supa::Sequence.word(5),
                 last_name: Supa::Sequence.word(8))
    end
  end
end
