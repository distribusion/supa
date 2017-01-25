require 'spec_helper'

describe Supa::Commands::Collection do
  context 'when no render options passed' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when collection is returned by object method' do
      let(:object) { double(:dummy, articles: [{name: 'Title'}]) }

      it { expect(result).to eq(articles: [{name: 'Title'}]) }
    end

    context 'when collection is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq(articles: []) }
    end

    context 'when collection is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq(articles: nil) }
    end
  end

  context 'when no render options passed and it renders array of objects' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when collection is returned by object method' do
      let(:object) { double(:dummy, articles: [double(:article, name: 'Title')]) }

      it { expect(result).to eq(articles: [{name: 'Title'}]) }
    end
  end

  context 'when option to hide empty collection is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles, hide_when_empty: true do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when collection is returned by object method' do
      let(:object) { double(:dummy, articles: [{name: 'Title'}]) }

      it { expect(result).to eq(articles: [{name: 'Title'}]) }
    end

    context 'when collection is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq({}) }
    end

    context 'when collection is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq({}) }
    end
  end

  context 'when option to convert nil to empty object is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles, empty_when_nil: true do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when collection is returned by object method' do
      let(:object) { double(:dummy, articles: [{name: 'Title'}]) }

      it { expect(result).to eq(articles: [{name: 'Title'}]) }
    end

    context 'when collection is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq(articles: []) }
    end

    context 'when collection is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq(articles: []) }
    end
  end

  context 'when option to hide empty and empty collection are true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles, empty_when_nil: true, hide_when_empty: true do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when collection is returned by object method' do
      let(:object) { double(:dummy, articles: [{name: 'Title'}]) }

      it { expect(result).to eq(articles: [{name: 'Title'}]) }
    end

    context 'when collection is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq({}) }
    end

    context 'when collection is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq({}) }
    end
  end
end
