require_relative 'author'
require_relative 'comment'

module Supa
  class Article
    attr_accessor :id, :title, :text, :author, :comments

    def initialize(id:, title:, text:, author:, comments:)
      @id = id
      @title = title
      @text = text
      @author = author
      @comments = comments
    end
  end

  module Fixtures
    class << self
      def article(id: nil, title: nil, text: nil, author: nil, comments: nil)
        Article.new(id: id || Supa::Sequence.id,
                    title: title || Supa::Sequence.word(20),
                    text: text || Supa::Sequence.word(40),
                    author: author || Supa::Fixtures.author,
                    comments: comments || 2.times.map { Supa::Fixtures.comment })
      end

      def article_with_comments(comment_count)
        article(comments: comment_count.times.map { Supa::Fixtures.comment })
      end
    end
  end
end
