# worte - A simple Ruby spell checker

[![Build Status](https://travis-ci.org/jonasoberschweiber/worte.svg?branch=master)](https://travis-ci.org/jonasoberschweiber/worte)

Worte is a simple spell checker based on [ffi-aspell](https://github.com/YorickPeterse/ffi-aspell).
It tokenizes strings, spell checks the tokens and can then print out the lines
of the original text containing spelling mistakes.

## Installation

Just install it using `gem install worte` or add it to your Gemfile. Please note
that worte depends on ffi-aspell, which requires an installation of aspell.

## Usage

Spell checking is done by `Worte::Worte`. Create a new instance, passing it the
language you want to check:

```ruby
worte = Worte::Worte.new('en')
```

You can also pass in some options, most of which will be passed through to
ffi-aspell. The most useful one might be `:personal`, which you can use to tell
aspell the path to your personal word list. The word list has to be in a
[specific format.](http://aspell.net/man-html/Format-of-the-Personal-and-Replacement-Dictionaries.html)

The `:filter` and `:filters` option can be used to specify one or more filters.
See below for details.

Use the `check` method to spell check some text and get back a list of `Token`
objects. The most important attributes of each token are `word`, `position` and
`correct`.

You can use the token list with one of the built-in printers to highlight
spelling mistakes in the original text, or use the information contained in the
token objects to do your own highlighting.

### Filters

Filters are used to filter out some parts of the original text before spell
checking, e.g. URLs or formatting. They are simple Ruby classes that implement
a `filter` method, which just takes a string and returns a string. A filter must
replace the filtered out bits by space characters. Otherwise the positions in
the tokens returned by check don't match the original text.

Worte ships with two filters. The first is `Worte::Filter::URL`, which simply
strips all URLs from the text. The other one is `Worte::Filter::Markdown`, which
filters out Markdown formatting. The Markdown filter is still very much a work
in progress!

### Printing

There are two printers included with worte: `Worte::Printer::Simple` and
`Worte::Printer::Colorized`. The simple printer prints out all lines containing
at least one spelling mistake and marks the mistake in the line below. Like
this:

```
1: A sipmle spelling mistake.
     ^^^^^^
```

The colorized variant prints out the markings in red.

## Example

```ruby
require 'worte'

text = "A sipmle spelling mistake"

tokens = Worte::Worte.new('en').check(text)
Worte::Printer::Simple.print(text, tokens)

# Output:
# 1: A sipmle spelling mistake
#      ^^^^^^
```

## License

Worte is licensed under the MIT license. See the `LICENSE` file for details.
