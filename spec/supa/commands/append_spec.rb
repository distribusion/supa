require 'spec_helper'

describe Supa::Commands::Append do
  context 'when no render options passed' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          append :articles do
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

  context 'when option to hide empty collection is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          append :articles, hide_when_empty: true do
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
          append :articles, empty_when_nil: true do
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
          append :articles, empty_when_nil: true, hide_when_empty: true do
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

  context 'when append is going after collection' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
          append :articles, getter: :papers do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [{name: 'Title'}], papers: [{name: 'Title 2'}]) }

    it 'combines two collections together' do
      expect(result).to eq(articles: [{name: 'Title'}, {name: 'Title 2'}])
    end
  end

  context 'when append is going before collection' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          append :articles, getter: :papers do
            attribute :name
          end
          collection :articles do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [{name: 'Title'}], papers: [{name: 'Title 2'}]) }

    it 'shows only collection items' do
      expect(result).to eq(articles: [{name: 'Title'}])
    end
  end

  context 'when applied two appends' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          append :articles, getter: :papers do
            attribute :name
          end
          append :articles do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [{name: 'Title'}], papers: [{name: 'Title 2'}]) }

    it 'combines two collections together' do
      expect(result).to eq(articles: [{name: 'Title 2'}, {name: 'Title'}])
    end
  end

  context 'when applied two appends' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles, hide_when_empty: true do
            attribute :name
          end
          append :articles, getter: :papers do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [], papers: [{name: 'Title 2'}]) }

    it 'shows only papers items' do
      expect(result).to eq(articles: [{name: 'Title 2'}])
    end
  end

  context 'when applied two appends' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
          append :articles, getter: :papers, hide_when_empty: true do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [{name: 'Title'}], papers: []) }

    it 'it shows only articles items' do
      expect(result).to eq(articles: [{name: 'Title'}])
    end
  end

  context 'when append after collection is nil' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
          append :articles, getter: :papers do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: [{name: 'Title'}], papers: nil) }

    it 'it shows only articles items' do
      expect(result).to eq(articles: [{name: 'Title'}])
    end
  end

  context 'when append after collection is nil' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles do
            attribute :name
          end
          append :articles, getter: :papers do
            attribute :name
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }
    let(:object) { double(:dummy, articles: nil, papers: [{name: 'Title 2'}]) }

    it 'it shows only articles items' do
      expect(result).to eq(articles: [{name: 'Title 2'}])
    end
  end
end
