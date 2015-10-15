# encoding: utf-8

require 'ffi/aspell'

module Worte
  class Worte
    def initialize(language, options={})
      @language = language
      @options = options
    end

    def check(str)
      tokens = Tokenizer.new.tokenize(str)
      FFI::Aspell::Speller.open(@language, @options) do |speller|
        tokens.each do |token|
          token.correct = speller.correct?(token.word)
        end
      end
      tokens
    end
  end
end
