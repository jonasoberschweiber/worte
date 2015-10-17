require 'spec_helper'

describe Worte::Filter::Markdown do
  it "filters out star emphasis" do
    f = Worte::Filter::Markdown.new
    t = f.filter('Test *test* test')
    expect(t).to eq('Test  test  test')
  end

  it "filters out star bold" do
    f = Worte::Filter::Markdown.new
    t = f.filter('Test **test** test')
    expect(t).to eq('Test   test   test')
  end

  it "filters out underline emphasis" do
    f = Worte::Filter::Markdown.new
    t = f.filter('Test _test_ test')
    expect(t).to eq('Test  test  test')
  end

  it "filters out underline bold" do
    f = Worte::Filter::Markdown.new
    t = f.filter('Test __test__ test')
    expect(t).to eq('Test   test   test')
  end

  it "filters out multiline underline emphasis" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test _test test\nTest123_ Test")
    expect(t).to eq("Test  test test\nTest123  Test")
  end

  it "filters out multiline underline bold" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test __test test\nTest123__ Test")
    expect(t).to eq("Test   test test\nTest123   Test")
  end

  it "filters out multiline star emphasis" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test *test test\nTest123* Test")
    expect(t).to eq("Test  test test\nTest123  Test")
  end

  it "filters out multiline star bold" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test **test test\nTest123** Test")
    expect(t).to eq("Test   test test\nTest123   Test")
  end

  it "filters heading marks" do
    f = Worte::Filter::Markdown.new
    t = f.filter('### Test')
    expect(t).to eq('    Test')
  end

  it "filters out Jekyll property block" do
    f = Worte::Filter::Markdown.new
    t = f.filter(<<-EOF
---
title: Test test test
category: ---test
---
Hello, World
EOF
    )
    expect(t).to eq("\n\n\n\n\nHello, World\n")
  end

  it "filters out inline backticks" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test `test` Test")
    expect(t).to eq("Test        Test")
  end

  it "filters out fenced code blocks" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test\n```ruby\nx = 1 + 2\nputs(x)\n```\nHello, World!")
    expect(t).to eq("Test\n\n\n\n\nHello, World!")
  end

  it "filters out indented pre blocks" do
    f = Worte::Filter::Markdown.new
    t = f.filter("Test\n\tThis\n\tis\n\ta pre block\nHello, World")
    expect(t).to eq("Test\n\n\n\nHello, World")
  end
end
