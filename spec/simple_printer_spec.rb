require 'spec_helper'

describe Worte::Printer::Simple do
  TEXT = <<-EOF
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vitae mi neque. Sed tempus libero placerat tellus
scelerisque condimentum. Nunc augue orci, aliquam sit amet lacus sit amet, volutpat molestie tellus. In eu egestas erat, et
fringilla orci. Suspendisse est ipsum, scelerisque varius porta a, ornare non dolor. Sed placerat ex risus. Donec posuere
fringilla ornare. Aliquam suscipit gravida ex sit amet rhoncus. Vivamus fringilla dui ut dui fermentum, eu volutpat justo
vulputate. Sed ut semper ipsum. Pellentesque varius tempus congue. Duis ullamcorper gravida velit non rhoncus. Nulla
facilisi. In vel placerat mauris, semper venenatis metus. Sed efficitur, metus eu efficitur placerat, lacus diam pharetra
lectus, a accumsan ante mi ut neque. Integer vitae posuere nisl.
  EOF

  it "skips lines without incorrect tokens" do
    pr = Worte::Printer::Simple.new
    o = StringIO.new
    tokens = Worte::Tokenizer.new.tokenize(TEXT)
    pr.print(TEXT, tokens, o)
    expect(o.string.length).to eq(0)
  end

  it "prints line numbers" do
    pr = Worte::Printer::Simple.new
    o = StringIO.new
    tokens = Worte::Tokenizer.new.tokenize(TEXT)
    tokens[40].correct = false
    pr.print(TEXT, tokens, o)
    expect(o.string).to start_with('3: ')
  end

  it "marks incorrect words" do
    pr = Worte::Printer::Simple.new
    o = StringIO.new
    sample = "This is a simple test"
    tokens = Worte::Tokenizer.new.tokenize(sample)
    tokens[3].correct = false
    pr.print(sample, tokens, o)
    expect(o.string.split("\n")[1]).to start_with('          ^^^^^^')
  end
end
