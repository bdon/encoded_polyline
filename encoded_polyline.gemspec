# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)
require 'encoded_polyline/version'

Gem::Specification.new do |s|
  s.name = "encoded_polyline"
  s.version = EncodedPolyline::VERSION
  s.authors = ["Brandon Liu"]
  s.email = "bdon@bdon.org"
  s.date = "2013-02-20"
  s.description = "Encode an array of coordinates for the Google Static Maps and MapQuest APIs."
  s.summary = "Encode an array of coordinates"
  s.homepage = "http://github.com/bdon/encoded_polyline"

  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")

  s.add_development_dependency("rake")
  s.add_development_dependency("rspec", "~> 1.3.1")
end
