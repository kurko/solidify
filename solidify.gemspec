# -*- encoding: utf-8 -*-
require File.expand_path('../lib/solidify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kurko"]
  gem.email         = ["chavedomundo@gmail.com"]
  gem.description   = %q{Inspect your code quality}
  gem.summary       = %q{Inspect your code quality}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "solidify"
  gem.require_paths = ["lib"]
  gem.version       = Solidify::VERSION
end
