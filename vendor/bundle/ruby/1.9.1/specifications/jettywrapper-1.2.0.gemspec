# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jettywrapper"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bess Sadler"]
  s.date = "2011-11-29"
  s.description = "Spin up a jetty instance (e.g., the one at https://github.com/projecthydra/hydra-jetty) and wrap test in it. This lets us run tests against a real copy of solr and fedora."
  s.email = ["bess@stanford.edu"]
  s.homepage = "https://github.com/projecthydra/jettywrapper"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "Convenience tasks for working with jetty from within a ruby project."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<logger>, [">= 0"])
      s.add_runtime_dependency(%q<mediashelf-loggable>, [">= 0"])
      s.add_runtime_dependency(%q<childprocess>, [">= 0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["< 2.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["= 0.6.5"])
      s.add_development_dependency(%q<RedCloth>, [">= 0"])
    else
      s.add_dependency(%q<logger>, [">= 0"])
      s.add_dependency(%q<mediashelf-loggable>, [">= 0"])
      s.add_dependency(%q<childprocess>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<rspec>, ["< 2.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<yard>, ["= 0.6.5"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
    end
  else
    s.add_dependency(%q<logger>, [">= 0"])
    s.add_dependency(%q<mediashelf-loggable>, [">= 0"])
    s.add_dependency(%q<childprocess>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<rspec>, ["< 2.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<yard>, ["= 0.6.5"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
  end
end
