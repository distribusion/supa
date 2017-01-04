require 'spec_helper'

describe Supa::VERSION do
  it 'has a version number' do
    expect(::Supa::VERSION).not_to be_nil
  end
end
