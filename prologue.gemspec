# -*- encoding: utf-8 -*-
require File.expand_path("../lib/prologue/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "prologue"
  s.version     = Prologue::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Quick Left"]
  s.email       = ["info@quickleft.com"]
  s.homepage    = "http://github.com/quickleft/prologue"
  s.summary     = "prologue-#{s.version}"
  s.description = "Generate a Rails 3 app with application templates Quick Left uses to start their projects off right!"

  s.rubyforge_project         = "prologue"
  s.required_rubygems_version = "> 1.3.6"

  # Runtime Dependencies
  s.add_dependency "activesupport" , "~> 3.0.7"
  s.add_dependency "rails"         , "~> 3.0.7"
  s.add_dependency "thor"          , "~> 0.14.6"

  # Development Dependencies
  s.add_development_dependency "aruba"    , "~> 0.2.3"
  s.add_development_dependency "bundler"  , "~> 1.0.12"
  s.add_development_dependency "cucumber" , "~> 0.9.3"
  s.add_development_dependency "rspec"    , "~> 2.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = "lib"
end

