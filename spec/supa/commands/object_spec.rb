require 'spec_helper'

describe Supa::Commands::Object do
  context 'when no render options passed' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          object :article do
            attribute :name
            attribute :cover
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) { double(:dummy, article: {name: 'Title', cover: 'black'}) }

      it { expect(result).to eq({article: {name: 'Title', cover: 'black'}}) }
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, article: nil) }

      it { expect(result).to eq({article: nil}) }
    end
  end

  context 'when option to hide empty object is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          object :article, hide_when_empty: true do
            attribute :name
            attribute :cover
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) { double(:dummy, article: {name: 'Title', cover: 'black'}) }

      it { expect(result).to eq({article: {name: 'Title', cover: 'black'}}) }
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, article: nil) }

      it { expect(result).to eq({}) }
    end
  end

  context 'when option conver nil to empty object is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          object :article, empty_when_nil: true do
            attribute :name
            attribute :cover
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) { double(:dummy, article: {name: 'Title', cover: 'black'}) }

      it { expect(result).to eq({article: {name: 'Title', cover: 'black'}}) }
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, article: nil) }

      it { expect(result).to eq({article: {:name=>nil, :cover=>nil}}) }
    end
  end

  context 'when option conver nil to empty object and hide when empty are true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          object :article, empty_when_nil: true, hide_when_empty: true do
            attribute :name
            attribute :cover
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) { double(:dummy, article: {name: 'Title', cover: 'black'}) }

      it { expect(result).to eq({article: {name: 'Title', cover: 'black'}}) }
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, article: nil) }

      it { expect(result).to eq({}) }
    end
  end
end
