require 'spec_helper'

describe 'Supa Benchmark' do
  bench_performance_linear '#to_hash' do |n|
    Supa::ArticleRepresenter.new(Supa::Fixtures.article_with_comments(n)).to_hash
  end

  bench_performance_linear '#to_json' do |n|
    Supa::ArticleRepresenter.new(Supa::Fixtures.article_with_comments(n)).to_json
  end
end
