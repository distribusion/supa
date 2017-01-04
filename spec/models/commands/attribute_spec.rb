require 'spec_helper'

describe Supa::Commands::Attribute do
  let(:context) { OpenStruct.new(name: 'Zaphod') }
  subject(:attribute) { Supa::Commands::Attribute.new(context: context, name: :name, tree: {}, options: options) }
  let(:render_result) { attribute.represent }
  let(:expected_name) { 'Zaphod' }

  describe '#initialize' do
    it '' do
    end
  end

  describe '#represent' do
    let(:options) { {} }

    it { expect(render_result).to eq(expected_name) }
  end

  describe '#getter' do
    context 'as proc' do
      let(:options) { { getter: proc { self.name } } }

      it { expect(render_result).to eq(expected_name) }
    end

    context 'as string literal' do
      let(:options) { { getter: 'Bluejay' } }
      let(:expected_name) { 'Bluejay' }

      it { expect(render_result).to eq(expected_name) }
    end

    context 'as numeric literal' do
      let(:options) { { getter: 1.75 } }
      let(:expected_name) { 1.75 }

      it { expect(render_result).to eq(expected_name) }
    end
  end
end
