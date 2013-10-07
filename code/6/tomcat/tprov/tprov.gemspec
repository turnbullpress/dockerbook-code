# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "tprov"
  s.version     = TProv::VERSION
  s.authors     = ["James Turnbull"]
  s.email       = ["james@lovedthanlost.net"]
  s.homepage    = "http://www.dockerbook.com"
  s.summary     = %q{A simple app to provision Tomcat apps with Docker}
  s.description = %q{A simple app to provision Tomcat apps with Docker written for The Docker Book - http://www.dockerbook.com}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "sinatra"
  s.add_dependency "haml"
  s.add_dependency "sass"
  s.add_dependency "json"
  s.add_dependency "sinatra-flash"
  s.add_dependency "sinatra-static-assets"
  s.add_dependency "emk-sinatra-url-for"
  s.add_dependency "sinatra-redirect-with-flash"
end
