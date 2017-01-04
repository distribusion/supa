require 'spec_helper'

describe Supa::VERSION do
  it 'has a version number' do
    expect(::Supa::VERSION).not_to eq(nil)
  end
end
