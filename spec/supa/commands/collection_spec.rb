require 'spec_helper'

describe Supa::Commands::Collection do
  context 'when collection is returned by object method' do
    let(:object) { double(:dummy, articles: [{name: 'Title'}]) }
    let(:representer) do
      Class.new do
        include Supa::Representable

        define do
          collection :articles, getter: :itself do
            attribute :name
          end
        end
      end
    end

    
  end
end
