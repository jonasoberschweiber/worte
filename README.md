# worte - A simple Ruby spell checker

Worte is a simple spell checker based on [ffi-aspell](https://github.com/YorickPeterse/ffi-aspell).
It tokenizes strings, spell checks the tokens and can then print out the lines
of the original text containing spelling mistakes.

## Installation

Just install it using `gem install worte` or add it to your Gemfile. Please note
that worte depends on ffi-aspell, which requires an installation of aspell.

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
