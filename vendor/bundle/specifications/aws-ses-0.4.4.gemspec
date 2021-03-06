# -*- encoding: utf-8 -*-
# stub: aws-ses 0.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "aws-ses"
  s.version = "0.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Drew Blas", "Marcel Molina Jr."]
  s.date = "2011-11-18"
  s.description = "Client library for Amazon's Simple Email Service's REST API"
  s.email = "drew.blas@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.erb", "README.rdoc", "TODO"]
  s.files = ["LICENSE", "README.erb", "README.rdoc", "TODO"]
  s.homepage = "http://github.com/drewblas/aws-ses"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Client library for Amazon's Simple Email Service's REST API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-simple>, [">= 0"])
      s.add_runtime_dependency(%q<builder>, [">= 0"])
      s.add_runtime_dependency(%q<mime-types>, [">= 0"])
      s.add_runtime_dependency(%q<mail>, ["> 2.2.5"])
      s.add_development_dependency(%q<shoulda-context>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<flexmock>, ["~> 0.8.11"])
    else
      s.add_dependency(%q<xml-simple>, [">= 0"])
      s.add_dependency(%q<builder>, [">= 0"])
      s.add_dependency(%q<mime-types>, [">= 0"])
      s.add_dependency(%q<mail>, ["> 2.2.5"])
      s.add_dependency(%q<shoulda-context>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<flexmock>, ["~> 0.8.11"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 0"])
    s.add_dependency(%q<builder>, [">= 0"])
    s.add_dependency(%q<mime-types>, [">= 0"])
    s.add_dependency(%q<mail>, ["> 2.2.5"])
    s.add_dependency(%q<shoulda-context>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<flexmock>, ["~> 0.8.11"])
  end
end
