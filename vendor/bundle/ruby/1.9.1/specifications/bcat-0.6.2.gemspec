# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bcat"
  s.version = "0.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Tomayko"]
  s.date = "2011-09-10"
  s.description = "pipe to browser utility"
  s.email = "rtomayko@gmail.com"
  s.executables = ["a2h", "bcat", "btee"]
  s.extra_rdoc_files = ["COPYING"]
  s.files = ["bin/a2h", "bin/bcat", "bin/btee", "COPYING"]
  s.homepage = "http://rtomayko.github.com/bcat/"
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Concatenate input from standard input, or one or more files, and write progressive output to a browser."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.0"])
    else
      s.add_dependency(%q<rack>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.0"])
  end
end
