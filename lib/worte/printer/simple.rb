# encoding: utf-8

module Worte
  module Printer
    class Simple
      def print(text, tokens, where=STDOUT)
        text.split("\n").each_with_index do |line, l|
          line_tokens = tokens.select { |t| t.position[0] == l }
          if line_tokens.collect(&:correct).all?
            next # Do not print lines without errors
          end
          where.print "#{l + 1}: "
          where.puts line
          col = 0
          line_tokens.each do |token|
            if !token.correct
              if col != token.position[1]
                where.print (' ' * (token.position[1] - col))
                col = token.position[1]
              end
              where.print error_marker(token.word.length)
              col += token.word.length
            end
          end
          where.puts
        end
      end

      def error_marker(length)
        '^' * length
      end
    end
  end
end
