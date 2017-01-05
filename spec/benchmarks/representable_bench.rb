require 'spec_helper'
require 'benchmark'

describe 'Supa Benchmark', 'linear performance' do
  def article_representable(article_number)
    Supa::ArticleRepresenter.new(Supa::Fixtures.article_with_comments(article_number))
  end

  def benchmark_execution_time
    benchmark_times = (0..5).each_with_object([]) do |_, times|
      times << Benchmark.realtime do
        yield
      end
    end
    benchmark_times.max
  end

  describe '#to_hash' do
    let(:execution_time_10) { benchmark_execution_time { article_representable(10).to_hash } }
    let(:article_representable_50) { article_representable(50) }
    let(:article_representable_100) { article_representable(100) }

    it 'rendering 50 comments' do
      expect { article_representable_50.to_hash }.to perform_under(execution_time_10 * 5 * 1.05)
    end

    it 'rendering 100 comments' do
      expect { article_representable_100.to_hash }.to perform_under(execution_time_10 * 10 * 1.05)
    end
  end

  describe '#to_json' do
    let(:execution_time_10) { benchmark_execution_time { article_representable(10).to_json } }
    let(:article_representable_50) { article_representable(50) }
    let(:article_representable_100) { article_representable(100) }

    it 'rendering 50 comments' do
      expect { article_representable_50.to_json }.to perform_under(execution_time_10 * 5 * 1.05)
    end

    it 'rendering 100 comments' do
      expect { article_representable_100.to_json }.to perform_under(execution_time_10 * 10 * 1.05)
    end
  end
end
