require 'spec_helper'

describe Supa::Commands::Attributes, 'options' do
  let(:object) { double('DummyUser', first_name: 'Zaphod', last_name: 'Dohpaz') }
  subject(:result) { representer.new(object).to_hash }

  context 'when :hide_when_empty option is set to true' do
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          attributes :first_name, :last_name, hide_when_empty: true
        end
      end
    end

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
