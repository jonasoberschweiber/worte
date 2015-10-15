# These are shamelessly copied from https://github.com/jnunemaker/flipper

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "worte/version"

desc 'Build gem into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  system "gem build worte.gemspec"
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

desc 'Tags version, pushes to remote, and pushes gem'
task :release => :build do
  sh 'git', 'tag', "v#{Worte::VERSION}"
  sh "git push origin master"
  sh "git push origin v#{Worte::VERSION}"
  sh "ls pkg/*.gem | xargs -n 1 gem push"
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color)
end

task :default => :spec
