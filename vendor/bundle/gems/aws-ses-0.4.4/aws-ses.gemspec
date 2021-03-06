# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{aws-ses}
  s.version = "0.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Drew Blas", "Marcel Molina Jr."]
  s.date = %q{2011-11-19}
  s.description = %q{Client library for Amazon's Simple Email Service's REST API}
  s.email = %q{drew.blas@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.erb",
    "README.rdoc",
    "TODO"
  ]
  s.files = [
    ".document",
    "CHANGELOG",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.erb",
    "README.rdoc",
    "Rakefile",
    "TODO",
    "VERSION",
    "aws-ses.gemspec",
    "lib/aws/actionmailer/ses_extension.rb",
    "lib/aws/ses.rb",
    "lib/aws/ses/addresses.rb",
    "lib/aws/ses/base.rb",
    "lib/aws/ses/extensions.rb",
    "lib/aws/ses/info.rb",
    "lib/aws/ses/response.rb",
    "lib/aws/ses/send_email.rb",
    "lib/aws/ses/version.rb",
    "test/address_test.rb",
    "test/base_test.rb",
    "test/extensions_test.rb",
    "test/fixtures.rb",
    "test/helper.rb",
    "test/info_test.rb",
    "test/mocks/fake_response.rb",
    "test/response_test.rb",
    "test/send_email_test.rb"
  ]
  s.homepage = %q{http://github.com/drewblas/aws-ses}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Client library for Amazon's Simple Email Service's REST API}
  s.test_files = [
    "test/address_test.rb",
    "test/base_test.rb",
    "test/extensions_test.rb",
    "test/fixtures.rb",
    "test/helper.rb",
    "test/info_test.rb",
    "test/mocks/fake_response.rb",
    "test/response_test.rb",
    "test/send_email_test.rb"
  ]

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

