require 'spec_helper'

describe Supa::Commands::Attribute do
  let(:object) { double('DummyArticle', name: 'Zaphod') }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  let(:attribute) do
    described_class.new(object, representer: representer, tree: {}, name: :name)
  end

  describe '#represent' do
    subject(:render_result) { attribute.represent }

    it { expect(render_result).to eq('Zaphod') }
  end
end
