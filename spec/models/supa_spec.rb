require 'spec_helper'

describe Supa::VERSION do
  it 'has a version number' do
    value(::Supa::VERSION).wont_be_nil
  end
end
