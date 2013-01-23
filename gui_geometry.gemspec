# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gui_geometry/version'

Gem::Specification.new do |gem|
  gem.name          = "gui_geometry"
  gem.version       = GuiGeometry::VERSION
  gem.authors       = ["Shane Brinkman-Davis"]
  gem.email         = ["shanebdavis@gmail.com"]
  gem.description   = %q{2D geometry specificly designed to support graphical user interfaces and bitmaps currently focsued on Point and Rectangle classes}
  gem.summary       = %q{2D geometry specificly designed to support graphical user interfaces and bitmaps}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-test'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'simplecov'
end
