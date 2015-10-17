module Worte
  module Filter
    class Markdown
      def filter(str)
        str = str.gsub(/^---$\n.*?\n^---$/m) { |c| "\n" * c.split("\n").length }
        str = str.gsub(/^```[a-z]*$\n.*?\n^```$/m) { |c| "\n" * (c.split("\n").length - 1) }
        str = str.gsub(/^\t.*$/) { |c| '' }
        str = str.gsub(/^([ \t]*[#]+)/) { |c| ' ' * c.length }
        str = str.gsub(/\*\*(.*?)\*\*/m) { |c| '  ' + c[2..-3] + '  ' }
        str = str.gsub(/\*(.*?)\*/m) { |c| ' ' + c[1..-2] + ' ' }
        str = str.gsub(/\_\_(.*?)\_\_/m) { |c| '  ' + c[2..-3] + '  ' }
        str = str.gsub(/\_(.*?)\_/m) { |c| ' ' + c[1..-2] + ' ' }
        str = str.gsub(/`.*?`/) { |c| ' ' * c.length }
        str = str.gsub(/[!]?\[.*\]\(.*\)/) { |c| ' ' * c.length }
      end
    end
  end
end
