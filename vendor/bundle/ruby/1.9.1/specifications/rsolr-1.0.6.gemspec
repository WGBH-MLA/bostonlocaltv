# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rsolr"
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Mitchell", "Jeremy Hinegardner", "Mat Brown", "Mike Perham", "Nathan Witmer", "Peter Kieltyka", "Randy Souza", "shairon toledo", "shima", "Chris Beer", "Jonathan Rochkind"]
  s.date = "2011-11-26"
  s.description = "RSolr aims to provide a simple and extensible library for working with Solr"
  s.email = ["goodieboy@gmail.com"]
  s.homepage = "https://github.com/mwmitchell/rsolr"
  s.require_paths = ["lib"]
  s.rubyforge_project = "rsolr"
  s.rubygems_version = "1.8.11"
  s.summary = "A Ruby client for Apache Solr"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.9.4"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
    else
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<rdoc>, ["~> 3.9.4"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<rdoc>, ["~> 3.9.4"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
  end
end
