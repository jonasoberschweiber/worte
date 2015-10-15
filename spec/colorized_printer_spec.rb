require 'spec_helper'

describe Worte::Printer::Colorized do
  it "marks incorrect tokens with red marker" do
    pr = Worte::Printer::Colorized.new
    o = StringIO.new
    sample = "This is a simple test"
    tokens = Worte::Tokenizer.new.tokenize(sample)
    tokens[3].correct = false
    pr.print(sample, tokens, o)
    expect(o.string.split("\n")[1]).to start_with("             \e[31m^^^^^^\e[0m")
  end
end
