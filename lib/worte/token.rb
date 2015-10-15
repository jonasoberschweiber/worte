# encoding: utf-8

module Worte
  class Token
    attr_accessor :word, :position, :correct, :newline

    def initialize(word, position)
      @word = word
      @position = position
      @correct = true
      @newline = false
    end
  end
end
