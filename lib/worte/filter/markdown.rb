module Worte
  module Filter
    class Markdown
      def filter(str)
        str = str.gsub(/^([ \t]*[#]+)/) { |c| ' ' * c.length }
        str = str.gsub(/\*\*(.*?)\*\*/) { |c| '  ' + c[2..-3] + '  ' }
        str = str.gsub(/\*(.*?)\*/) { |c| ' ' + c[1..-2] + ' ' }
        str = str.gsub(/[!]?\[.*\]\(.*\)/) { |c| ' ' * c.length }
      end
    end
  end
end
