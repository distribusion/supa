module Supa
  class Comment
    attr_accessor :id, :text

    def initialize(id:, text:)
      @id = id
      @text = text
    end
  end

  module Fixtures
    def self.comment
      Comment.new(id: Supa::Sequence.id,
                  text: Supa::Sequence.word(40))
    end
  end
end
