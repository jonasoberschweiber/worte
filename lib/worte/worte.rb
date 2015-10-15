# encoding: utf-8

require 'ffi/aspell'

module Worte
  class Worte
    def initialize(language, options={})
      @language = language

      @filters = options.delete(:filters) || []
      single_filter = options.delete(:filter)
      @filters << single_filter if single_filter

      @options = options
    end

    def check(str)
      @filters.each do |filter|
        str = filter.filter(str)
      end
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
