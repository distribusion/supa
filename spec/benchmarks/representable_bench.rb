require 'spec_helper'
require 'benchmark'

describe 'Supa Benchmark', 'linear performance' do
  def article_representable(article_number)
    Supa::ArticleRepresenter.new(Supa::Fixtures.article_with_comments(article_number))
  end

  def benchmark_execution_time
    if block_given?
      benchmark_times = (0..5).each_with_object([]) do |i, times|
        times << Benchmark.realtime do
          yield
        end
      end
      benchmark_times.max
    end
  end

  describe '#to_hash' do
    let(:execution_time_10) do
      benchmark_execution_time do
        article_representable(10).to_hash
      end
    end
    let(:article_representable_50) { article_representable(50) }
    let(:article_representable_100) { article_representable(100) }

    it '50 articles' do
      expect { article_representable_50.to_hash }.to perform_under(execution_time_10 * 5 * 1.05)
    end
    it '100 articles' do
      expect { article_representable_100.to_hash }.to perform_under(execution_time_10 * 10 * 1.05)
    end
  end

  describe '#to_json' do
    let(:execution_time_10) do
      benchmark_execution_time do
        article_representable(10).to_json
      end
    end
    let(:article_representable_50) { article_representable(50) }
    let(:article_representable_100) { article_representable(100) }

    it '50 articles' do
      expect { article_representable_50.to_json }.to perform_under(execution_time_10 * 5 * 1.05)
    end
    it '100 articles' do
      expect { article_representable_100.to_json }.to perform_under(execution_time_10 * 10 * 1.05)
    end
  end
end
