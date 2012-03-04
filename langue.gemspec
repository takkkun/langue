# -*- encoding: utf-8 -*-
require File.expand_path('../lib/langue/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Takahiro Kondo"]
  gem.email         = ["kondo@atedesign.net"]
  gem.description   = %q{It is the foundation to provide the operations to the natural languages.}
  gem.summary       = %q{The foundation for the natural languages}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "langue"
  gem.require_paths = ["lib"]
  gem.version       = Langue::VERSION

  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'autotest'
  gem.add_development_dependency 'autotest-fsevent'
  gem.add_development_dependency 'autotest-growl'
end
