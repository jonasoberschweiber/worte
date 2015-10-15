# encoding: utf-8

module Worte
  module Printer
    class Colorized < Simple
      def error_marker(length)
        "\e[31m" + ('^' * length) + "\e[0m"
      end
    end
  end
end
