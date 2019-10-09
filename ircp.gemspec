# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ircp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mashiro"]
  gem.email         = ["mail@mashiro.org"]
  gem.description   = %q{IRC minimal parser}
  gem.summary       = %q{IRC minimal parser for ruby}
  gem.homepage      = "https://github.com/mashiro/ircp-ruby"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ircp"
  gem.require_paths = ["lib"]
  gem.version       = Ircp::VERSION

  gem.add_dependency 'treetop', '>= 1.4.10'
  gem.add_development_dependency 'rake', '~> 0.9.2'
  gem.add_development_dependency 'rspec', '~> 3.9.0'
end
