# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "cucumber-rails"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aslak Helles\u{f8}y", "Dennis Bl\u{f6}te", "Rob Holland"]
  s.date = "2011-12-04"
  s.description = "Cucumber Generator and Runtime for Rails"
  s.email = "cukes@googlegroups.com"
  s.homepage = "http://cukes.info"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "cucumber-rails-1.2.1"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber>, [">= 1.1.3"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_runtime_dependency(%q<capybara>, [">= 1.1.2"])
      s.add_development_dependency(%q<rails>, [">= 3.1.3"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2.2"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.21"])
      s.add_development_dependency(%q<aruba>, [">= 0.4.7"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.5"])
      s.add_development_dependency(%q<rspec>, [">= 2.7.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.7.0"])
      s.add_development_dependency(%q<ammeter>, [">= 0.2.1"])
      s.add_development_dependency(%q<factory_girl>, [">= 2.3.2"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.7.0"])
      s.add_development_dependency(%q<mongoid>, [">= 2.3.4"])
      s.add_development_dependency(%q<bson_ext>, [">= 1.5.1"])
      s.add_development_dependency(%q<turn>, [">= 0.8.3"])
      s.add_development_dependency(%q<sass-rails>, [">= 3.1.5"])
      s.add_development_dependency(%q<coffee-rails>, [">= 3.1.1"])
      s.add_development_dependency(%q<uglifier>, [">= 1.1.0"])
      s.add_development_dependency(%q<jquery-rails>, [">= 1.0.19"])
      s.add_development_dependency(%q<yard>, ["~> 0.7.4"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_development_dependency(%q<bcat>, ["~> 0.6.2"])
    else
      s.add_dependency(%q<cucumber>, [">= 1.1.3"])
      s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
      s.add_dependency(%q<capybara>, [">= 1.1.2"])
      s.add_dependency(%q<rails>, [">= 3.1.3"])
      s.add_dependency(%q<rake>, [">= 0.9.2.2"])
      s.add_dependency(%q<bundler>, [">= 1.0.21"])
      s.add_dependency(%q<aruba>, [">= 0.4.7"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
      s.add_dependency(%q<rspec>, [">= 2.7.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.7.0"])
      s.add_dependency(%q<ammeter>, [">= 0.2.1"])
      s.add_dependency(%q<factory_girl>, [">= 2.3.2"])
      s.add_dependency(%q<database_cleaner>, [">= 0.7.0"])
      s.add_dependency(%q<mongoid>, [">= 2.3.4"])
      s.add_dependency(%q<bson_ext>, [">= 1.5.1"])
      s.add_dependency(%q<turn>, [">= 0.8.3"])
      s.add_dependency(%q<sass-rails>, [">= 3.1.5"])
      s.add_dependency(%q<coffee-rails>, [">= 3.1.1"])
      s.add_dependency(%q<uglifier>, [">= 1.1.0"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0.19"])
      s.add_dependency(%q<yard>, ["~> 0.7.4"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
      s.add_dependency(%q<bcat>, ["~> 0.6.2"])
    end
  else
    s.add_dependency(%q<cucumber>, [">= 1.1.3"])
    s.add_dependency(%q<nokogiri>, [">= 1.5.0"])
    s.add_dependency(%q<capybara>, [">= 1.1.2"])
    s.add_dependency(%q<rails>, [">= 3.1.3"])
    s.add_dependency(%q<rake>, [">= 0.9.2.2"])
    s.add_dependency(%q<bundler>, [">= 1.0.21"])
    s.add_dependency(%q<aruba>, [">= 0.4.7"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.5"])
    s.add_dependency(%q<rspec>, [">= 2.7.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.7.0"])
    s.add_dependency(%q<ammeter>, [">= 0.2.1"])
    s.add_dependency(%q<factory_girl>, [">= 2.3.2"])
    s.add_dependency(%q<database_cleaner>, [">= 0.7.0"])
    s.add_dependency(%q<mongoid>, [">= 2.3.4"])
    s.add_dependency(%q<bson_ext>, [">= 1.5.1"])
    s.add_dependency(%q<turn>, [">= 0.8.3"])
    s.add_dependency(%q<sass-rails>, [">= 3.1.5"])
    s.add_dependency(%q<coffee-rails>, [">= 3.1.1"])
    s.add_dependency(%q<uglifier>, [">= 1.1.0"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0.19"])
    s.add_dependency(%q<yard>, ["~> 0.7.4"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<rdiscount>, ["~> 1.6.8"])
    s.add_dependency(%q<bcat>, ["~> 0.6.2"])
  end
end
