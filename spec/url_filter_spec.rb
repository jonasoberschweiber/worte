require 'spec_helper'

describe Worte::Filter::URL do
  it "replaces urls with spaces" do
    f = Worte::Filter::URL.new
    t = f.filter('Test http://google.de Test')
    expect(t).to eq('Test                  Test')
  end
end
