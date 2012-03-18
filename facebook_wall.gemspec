# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facebook_wall/version"

Gem::Specification.new do |s|
  s.name        = "facebook_wall"
  s.version     = FacebookWall::VERSION
  s.authors     = ["Dan Bettles"]
  s.email       = ["dan@archaichorizon.com"]
  s.homepage    = ""
  s.summary     = %q{FacebookWall is a very simple library that fetches the latest wall-posts for a Facebook page without having to log in - wall posts are taken from the page's RSS feed.}
  s.description = %q{FacebookWall is a very simple library that fetches the latest wall-posts for a Facebook page without having to log in - wall posts are taken from the page's RSS feed.  The markup in posts is filtered to help ensure standards-compliance and prevent errors when inserted into your own Web pages.}

  s.rubyforge_project = "facebook_wall"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  #s.add_runtime_dependency 'feedzirra', '~> 0.1.3'
end