# encoding: utf-8

# Inspired by tokenizer (https://github.com/arbox/tokenizer)

FS = Regexp.new('[[:blank:]]+')

BREAK = ['(', ')', '[', ']', '<', '>', '!', '?', ',', '.', ';', ':', '.', '"', "'"]

module Worte
  class Tokenizer
    def tokenize(str)
      reset

      str.split("\n").each_with_index do |line, l|
        @start_word = -1
        @buf_word = ''
        @last_token = nil

        line.each_char.with_index do |ch, c|
          case
          when FS.match(ch) || BREAK.include?(ch)
            add_token_from_buffer(l)
          else
            if @start_word == -1
              @start_word = c
            end
            @buf_word += ch
          end
        end

        add_token_from_buffer(l)

        if !@last_token
          # Add a dummy token that will get the newline flag
          @last_token = Token.new('', [l, 0])
          @tokens << @last_token
        end

        @last_token.newline = true
      end

      @tokens
    end

    private

    def reset
      @tokens = []
      @start_word = -1
      @buf_word = ''
      @last_token = nil
    end

    def add_token_from_buffer(line)
      if @buf_word.length > 0
        @last_token = Token.new(@buf_word, [line, @start_word])
        @tokens << @last_token
        @buf_word = ''
        @start_word = -1
      end
    end
  end
end
