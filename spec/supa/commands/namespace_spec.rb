require 'spec_helper'

describe Supa::Commands::Namespace do
  context 'when no render options passed' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          namespace :articles do
            collection :data, getter: :articles do
              attribute :name
              attribute :cover
            end
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) do
        double(
          :dummy,
          articles: [
            {name: 'Title', cover: 'black'},
            {name: 'Headline', cover: 'white'}
          ]
        )
      end

      it do
        expect(result).to eq(
          articles: {
            data: [
              {name: 'Title', cover: 'black'},
              {name: 'Headline', cover: 'white'}
            ]
          }
        )
      end
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq(articles: { data: nil } ) }
    end

    context 'when object is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq(articles: { data: [] }) }
    end
  end

  context 'when option to hide empty object is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          namespace :articles, hide_when_empty: true do
            collection :data, getter: :articles do
              attribute :name
              attribute :cover
            end
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) do
        double(
          :dummy,
          articles: [
            {name: 'Title', cover: 'black'},
            {name: 'Headline', cover: 'white'}
          ]
        )
      end

      it do
        expect(result).to eq(
          articles: {
            data: [
              {name: 'Title', cover: 'black'},
              {name: 'Headline', cover: 'white'}
            ]
          }
        )
      end
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq({}) }
    end

    context 'when object is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq({}) }
    end
  end

  context 'when option conver nil to empty object is true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          namespace :articles, empty_when_nil: true do
            collection :data, getter: :articles do
              attribute :name
              attribute :cover
            end
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) do
        double(
          :dummy,
          articles: [
            {name: 'Title', cover: 'black'},
            {name: 'Headline', cover: 'white'}
          ]
        )
      end

      it do
        expect(result).to eq(
          articles: {
            data: [
              {name: 'Title', cover: 'black'},
              {name: 'Headline', cover: 'white'}
            ]
          }
        )
      end
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq(articles: {}) }
    end

    context 'when object is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq(articles: { data: [] }) }
    end
  end

  context 'when option conver nil to empty object and hide when empty are true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          namespace :articles, hide_when_empty: true, empty_when_nil: true do
            collection :data, getter: :articles do
              attribute :name
              attribute :cover
            end
          end
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object is returned by object method' do
      let(:object) do
        double(
          :dummy,
          articles: [
            {name: 'Title', cover: 'black'},
            {name: 'Headline', cover: 'white'}
          ]
        )
      end

      it do
        expect(result).to eq(
          articles: {
            data: [
              {name: 'Title', cover: 'black'},
              {name: 'Headline', cover: 'white'}
            ]
          }
        )
      end
    end

    context 'when object is nil' do
      let(:object) { double(:dummy, articles: nil) }

      it { expect(result).to eq({}) }
    end

    context 'when object is empty' do
      let(:object) { double(:dummy, articles: []) }

      it { expect(result).to eq({}) }
    end
  end
end
