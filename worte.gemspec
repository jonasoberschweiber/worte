require File.expand_path('../lib/worte/version', __FILE__)

ignored_files = [".travis.yml", ".gitignore"]
ignored_files.uniq!

ignored_test_files = []

Gem::Specification.new do |gem|
  gem.authors = ["Jonas Oberschweiber"]
  gem.email = ["jonas@oberschweiber.com"]
  gem.summary = %q{Simple spell checker based on ffi-aspell}
  gem.description = %q{A simple spell checker based on ffi-aspell. Tokenizes texts, checks them and prints them out.}
  gem.homepage = "https://github.com/jonasoberschweiber/worte"
  gem.license = "MIT"

  gem.files         = `git ls-files`.split("\n") - ignored_files + ["lib/worte/version.rb"]
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n") - ignored_test_files
  gem.require_paths = ["lib"]
  gem.name = "worte"
  gem.version = Worte::VERSION

  gem.add_runtime_dependency "ffi-aspell", ["~> 1.1.0"]
end
