# encoding: utf-8

require 'uri'

module Worte
  module Filter
    class URL
      def filter(str)
        str.gsub(URI.regexp) { |c| ' ' * c.length }
      end
    end
  end
end
