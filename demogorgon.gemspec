# -*- encoding: utf-8 -*-
require File.expand_path('../lib/demogorgon/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "demogorgon"
  s.version     = Demogorgon::VERSION
  s.platform    = Gem::Platform::RUBY

  s.authors = ["Jeff McFadden"]
  s.date = "2016-08-29"
  s.description = "Text Adventure Framework"
  s.email = "jeff@mcfadden.io"
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]
  s.files        = `git ls-files`.split("\n")

  s.homepage = "http://github.com/jeffmcfadden/demogorgon"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Text Adventure Framework"
end