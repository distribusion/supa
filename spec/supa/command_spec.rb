require 'spec_helper'

describe Supa::Command do
  let(:command) { described_class.new(object, tree: tree, representer: representer, name: name, options: options) }
  let(:object) { Supa::Fixtures.article }
  let(:tree) { {} }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  let(:name) { :id }
  let(:options) { {} }

  describe '#value' do
    subject(:value) { command.send(:value) }

    let(:options) { {getter: getter} }

    context 'when given getter option is symbol (method name)' do
      context 'when object and representer do not respond to method passed in getter option' do
        let(:getter) { :not_existing_method }

        it 'raises NoMethodError' do
          expect { value }.to raise_error(
            NoMethodError,
            /undefined method `not_existing_method' for #<Supa::Article:.+> or #<Supa::ArticleRepresenter:.+>/
          )
        end
      end

      context 'when object responds to method passed in getter option' do
        let(:getter) { :id }

        before { allow(object).to receive(:id).and_return(5) }

        it { expect(value).to eq(5) }
      end

      context 'when representer responds to method passed in getter option' do
        let(:name) { :type }
        let(:getter) { :articles_type }

        before { allow(representer).to receive(:articles_type).and_return('articlesxxx') }

        it { expect(value).to eq('articlesxxx') }
      end
    end

    context 'when given getter option is Proc object' do
      let(:getter) { ->() { not_existing_method } }

      context 'when neither object nor representer respond to method called inside Proc block' do
        it 'raises NoMethodError' do
          expect { value }.to raise_error(
            NoMethodError,
            /undefined method `not_existing_method' for #<Supa::Article:.+> or #<Supa::ArticleRepresenter:.+>/
          )
        end
      end

      context 'when object responds to method called inside Prock block' do
        let(:getter) { ->() { id } }

        before { allow(object).to receive(:id).and_return(6) }

        it { expect(value).to eq(6) }
      end

      context 'when representer responds to method passed in getter option' do
        let(:name) { :articles_type }
        let(:getter) { ->() { articles_type } }

        before { allow(representer).to receive(:articles_type).and_return('articleszzz') }

        it { expect(value).to eq('articleszzz') }
      end
    end
  end
end
