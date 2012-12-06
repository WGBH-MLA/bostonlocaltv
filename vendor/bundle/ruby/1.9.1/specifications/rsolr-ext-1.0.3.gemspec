# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rsolr-ext"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mitchell", "James Davidson", "Chris Beer", "Jason Ronallo", "Eric Lindvall", "Andreas Kemkes"]
  s.date = "2011-06-08"
  s.description = "A query/response extension lib for RSolr"
  s.email = "goodieboy@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/mwmitchell/rsolr-ext"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A query/response extension lib for RSolr"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<rsolr>, [">= 1.0.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<rsolr>, [">= 1.0.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<rsolr>, [">= 1.0.2"])
  end
end
