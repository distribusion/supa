require 'spec_helper'

describe Supa::Commands::Attributes do
  let(:object) { double('DummyUser', first_name: 'Zaphod', last_name: 'Dohpaz') }
  let(:representer) do
    Class.new do
      include Supa::Representable

      define do
        attributes :first_name, :last_name
      end
    end
  end

  describe '#represent' do
    let(:result) { representer.new(object).to_hash }

    it { expect(result).to eq(first_name: 'Zaphod', last_name: 'Dohpaz') }
  end
end
