require 'spec_helper'

describe Supa::Commands::Attribute do
  let(:object) { double('DummyArticle', name: 'Zaphod') }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  let(:render_result) { attribute.represent }

  subject(:attribute) do
    described_class.new(object, name: :name, tree: {}, representer: representer, options: options)
  end

  describe '#initialize' do
    it '' do
    end
  end

  describe '#represent' do
    let(:options) { {} }

    it { expect(render_result).to eq('Zaphod') }
  end

  describe '#getter' do
    context 'as proc' do
      let(:options) { {getter: proc { self.name }} }

      it { expect(render_result).to eq('Zaphod') }
    end

    context 'as string literal' do
      let(:options) { {getter: 'Bluejay'} }

      it { expect(render_result).to eq('Bluejay') }
    end

    context 'as numeric literal' do
      let(:options) { {getter: 1.75} }

      it { expect(render_result).to eq(1.75) }
    end

    context 'as a Time' do
      let(:options) { {getter: Time.gm(2017, 1, 5, 12, 0)} }

      it { expect(render_result).to eq(Time.gm(2017, 1, 5, 12, 0)) }
    end

    context 'as a Date' do
      let(:options) { {getter: Date.new(2017, 1, 5)} }

      it { expect(render_result).to eq(Date.new(2017, 1, 5)) }
    end

    context 'as Trueclass' do
      let(:options) { {getter: true} }

      it { expect(render_result).to eq(true) }
    end
  end
end
