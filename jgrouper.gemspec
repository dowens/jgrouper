# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jgrouper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['blair christensen']
  gem.email         = ['blair.christensen@gmail.com']
  gem.description   = %q{JRuby wrapper around the Internet2 Grouper API}
  gem.summary       = %q{JRuby wrapper around the Internet2 Grouper API}
  gem.homepage      = %q{https://github.com/blairc/jgrouper}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'jgrouper'
  gem.require_paths = ['lib']
  gem.version       = JGrouper::VERSION

  gem.add_dependency 'json'
  gem.add_dependency 'pry'

  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rdoc'
  gem.add_development_dependency 'rdoc-readme', '~> 0.1.2'
  gem.add_development_dependency 'simplecov'
end

