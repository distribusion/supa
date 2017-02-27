require 'spec_helper'

describe Supa::Commands::Attribute, 'options' do
  let(:object) { double('DummyArticle', name: 'Zaphod', full_name: 'Zaphod Dohpaz', name_as_sym: :zaphod) }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  let(:attribute) do
    described_class.new(object, representer: representer, tree: {}, name: :name, options: options)
  end
  subject(:render_result) { attribute.represent }

  context 'when :getter option is given' do
    let(:options) { {getter: :full_name} }

    it { expect(render_result).to eq('Zaphod Dohpaz') }
  end

  context 'when :getter and :modifier options are given' do
    let(:options) { {getter: :name_as_sym, modifier: :to_s} }

    it { expect(render_result).to eq('zaphod') }
  end

  context 'when :modifier option is a symbol (method name)' do
    let(:attribute) do
      described_class.new(object, representer: representer, tree: {}, name: :name_as_sym, options: options)
    end

    context 'when representer responds to given method name' do
      let(:options) { {modifier: :to_s} }

      it { expect(render_result).to eq('zaphod') }
    end

    context 'when representer does not respond to given method name' do
      let(:options) { {modifier: :to_string} }

      it 'raises error' do
        expect { render_result }.to raise_error(
          NoMethodError, /undefined method `to_string' for #<Supa::ArticleRepresenter/
        )
      end
    end
  end

  context 'when :modifier option holds unsupported value type' do
    let(:options) { {modifier: 'to_s'} }

    it 'raises error' do
      expect { render_result }.to raise_error(
        Supa::Command::UnsupportedModifier,
        'Object "to_s" is not a valid modifier. Please provide symbolized method name.'
      )
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
