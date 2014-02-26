# -*- encoding: utf-8 -*-
# stub: celluloid-pmap 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "celluloid-pmap"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jesse Wolgamott"]
  s.date = "2013-01-30"
  s.description = "Easy Parallel Executing using Celluloid"
  s.email = ["jesse@comalproductions.com"]
  s.homepage = "https://github.com/jwo/celluloid-pmap"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Celluloid Futures are wicked sweet, and when combined with a #pmap implementation AND a supervisor to keep the max threads down, you can be wicked sweet too!"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<celluloid>, ["~> 0.12"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<celluloid>, ["~> 0.12"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<celluloid>, ["~> 0.12"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
