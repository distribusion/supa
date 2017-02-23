require 'spec_helper'

describe Supa::Commands::Attribute do
  let(:object) { double('DummyArticle', name: 'Zaphod', surname: 'Surname', name_as_sym: :zaphod) }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  subject(:render_result) { attribute.represent }

  let(:attribute) do
    described_class.new(object, representer: representer, tree: {}, name: :name, options: options)
  end

  describe '#represent' do
    let(:options) { {} }

    it { expect(render_result).to eq('Zaphod') }
  end

  describe '#getter' do
    context 'when it renders surname as name' do
      let(:options) { {getter: :surname} }

      it { expect(render_result).to eq('Surname') }
    end

    context 'when render attribute with modifier' do
      let(:options) { {getter: :name_as_sym, modifier: :to_s} }

      it { expect(render_result).to eq('zaphod') }
    end
  end

  context 'when :hide_when_nil option is set to true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          attribute :name, hide_when_nil: true
        end
      end
    end
    let(:result) { representer.new(object).to_hash }

    context 'when object method returns non-nil value' do
      let(:object) { double(:dummy, name: 'John') }

      it { expect(result).to eq(name: 'John') }
    end

    context 'when object method returns nil' do
      let(:object) { double(:dummy, name: nil) }

      it { expect(result).to eq({}) }
    end
  end
end
