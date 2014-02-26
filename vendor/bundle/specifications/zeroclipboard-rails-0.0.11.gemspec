# -*- encoding: utf-8 -*-
# stub: zeroclipboard-rails 0.0.11 ruby lib

Gem::Specification.new do |s|
  s.name = "zeroclipboard-rails"
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Henrik Wenz", "Paul Jolly"]
  s.date = "2014-01-31"
  s.description = "ZeroClipboard libary support for Rails"
  s.email = ["handtrix@gmail.com"]
  s.homepage = "https://github.com/zeroclipboard/zeroclipboard-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Adds the Javascript ZeroClipboard libary to Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
  end
end
