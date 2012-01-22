# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ircp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mashiro"]
  gem.email         = ["mail@mashiro.org"]
  gem.description   = %q{irc parser}
  gem.summary       = %q{irc parser for ruby}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ircp"
  gem.require_paths = ["lib"]
  gem.version       = Ircp::VERSION

  gem.add_dependency 'treetop'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
