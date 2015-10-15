require 'spec_helper'

describe Worte::Tokenizer do
  it "sets newline flag on last token in line" do
    t = Worte::Tokenizer.new
    token = t.tokenize("test\n").first
    expect(token.newline).to be(true)
  end

  it "sets all tokens correct after tokenization" do
    t = Worte::Tokenizer.new
    tokens = t.tokenize("test test2 test3")
    expect(tokens.collect(&:correct).all?).to be(true)
  end

  it "removes parens and brackets" do
    t = Worte::Tokenizer.new
    tokens = t.tokenize("(test1) [test2] <test3>")
    expect(tokens.length).to eq(3)
    expect(tokens[0].word).to eq('test1')
    expect(tokens[1].word).to eq('test2')
    expect(tokens[2].word).to eq('test3')
  end

  it "breaks on punctuation" do
    t = Worte::Tokenizer.new
    tokens = t.tokenize("Ich, ging! Nach. Hause? Nicht: so; schnell")
    expect(tokens.length).to eq(7)
    %w(Ich ging Nach Hause Nicht so schnell).each_with_index do |e, i|
      expect(tokens[i].word).to eq(e)
    end
  end

  it "breaks on quotes" do
    t = Worte::Tokenizer.new
    tokens = t.tokenize("'Hello' sweet \"World\"")
    expect(tokens.length).to eq(3)
    %w(Hello sweet World).each_with_index do |e, i|
      expect(tokens[i].word).to eq(e)
    end
  end

  it "stores position in token" do
    t = Worte::Tokenizer.new
    tokens = t.tokenize("a bcd \n efg ")
    expect(tokens[0].position).to eq([0, 0])
    expect(tokens[1].position).to eq([0, 2])
    expect(tokens[2].position).to eq([1, 1])
  end
end
