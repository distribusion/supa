require 'spec_helper'

describe Supa::Builder do
  let(:object) { double('DummyUser', first_name: 'Zaphod', last_name: 'Dohpaz') }
  subject(:result) { representer.new(object).to_hash }

  describe '#attributes' do
    let(:options) { {} }
    let(:representer) do
      opts = options
      Class.new do
        include Supa::Representable

        define do
          attributes :first_name, :last_name, opts
        end
      end
    end

    it { expect(result).to eq(first_name: 'Zaphod', last_name: 'Dohpaz') }

    context 'when hide_when_empty option is set to true' do
      let(:options) { {hide_when_empty: true} }

      context 'when object method returns non-nil value' do
        before { allow(object).to receive(:last_name).and_return('Dohpaz') }

        it { expect(result).to eq(first_name: 'Zaphod', last_name: 'Dohpaz') }
      end

      context 'when object method returns nil' do
        before { allow(object).to receive(:last_name).and_return(nil) }

        it { expect(result).to eq(first_name: 'Zaphod') }
      end
    end
  end
end
