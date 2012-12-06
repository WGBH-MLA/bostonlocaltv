# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "marc"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Clarke", "Bill Dueber", "William Groppe", "Ross Singer", "Ed Summers"]
  s.autorequire = "marc"
  s.date = "2011-06-01"
  s.email = "ehs@pobox.com"
  s.homepage = "http://marc.rubyforge.org/"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = "1.8.11"
  s.summary = "A ruby library for working with Machine Readable Cataloging"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
