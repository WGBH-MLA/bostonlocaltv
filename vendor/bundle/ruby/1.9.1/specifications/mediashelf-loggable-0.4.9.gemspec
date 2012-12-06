# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mediashelf-loggable"
  s.version = "0.4.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Patrick Reagan", "Matt Zumwalt"]
  s.date = "2011-12-06"
  s.description = "A gem that provides logging capabilities to any class.  Relies on Rails logger if it's available.  Extended from loggable gem by viget"
  s.email = "matt.zumwalt@yourmediashelf.com"
  s.homepage = "http://github.com/mediashelf/loggable"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "A gem that provides logging capabilities to any class"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["< 2.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_development_dependency(%q<jnunemaker-matchy>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["= 0.6.5"])
      s.add_development_dependency(%q<RedCloth>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["< 2.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
      s.add_dependency(%q<jnunemaker-matchy>, [">= 0"])
      s.add_dependency(%q<yard>, ["= 0.6.5"])
      s.add_dependency(%q<RedCloth>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["< 2.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    s.add_dependency(%q<jnunemaker-matchy>, [">= 0"])
    s.add_dependency(%q<yard>, ["= 0.6.5"])
    s.add_dependency(%q<RedCloth>, [">= 0"])
  end
end
