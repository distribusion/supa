require 'spec_helper'

describe Supa::CommandContext do
  let(:command_context) { Supa::CommandContext.new(object, representer) }
  let(:representer) { Supa::ArticleRepresenter.new(object) }
  let(:object) { Supa::Fixtures.article }

  describe '#call' do
    subject(:call) { command_context.call(method) }

    context 'when object and representer do not respond to given method' do
      let(:method) { :not_existing_method }

      it 'raises NoMethodError' do
        expect { call }.to raise_error(
          NoMethodError,
          /undefined method `not_existing_method' for #<Supa::Article:.+> or #<Supa::ArticleRepresenter:.+>/
        )
      end
    end

    context 'when given method is Proc object' do
      let(:method) { ->() { not_existing_method } }

      context 'when neither object nor representer respond to method called inside Proc block' do
        it 'raises NoMethodError' do
          expect { call }.to raise_error(
            NoMethodError,
            /undefined method `not_existing_method' for #<Supa::Article:.+> or #<Supa::ArticleRepresenter:.+>/
          )
        end
      end
    end
  end
end
