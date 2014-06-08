# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tick/version"

Gem::Specification.new do |s|
  s.name        = "tick-ruby"
  s.version     = Tick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/tick-scheduler/tick-ruby"
  s.summary     = %q{API client for Tick Scheduler (tickscheduler.com)}
  s.description = %q{API client for Tick Scheduler (tickscheduler.com)}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'faraday_middleware-multi_json'
  s.add_dependency 'hashie'
end
