# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flotr}
  s.version = "1.3.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paolo Bosetti"]
  s.date = %q{2011-01-05}
  s.description = %q{Flotr (pron. like "plotter") is a Ruby plotter via flot.}
  s.email = %q{paolo.bosetti@me.com}
  s.files = ["README.markdown", "lib/excanvas.js", "lib/excanvas.pack.js", "lib/flotr.rb", "lib/interacting.rhtml", "lib/jquery.flot.js", "lib/jquery.min.js", "lib/layout.css", "lib/zooming.rhtml", "examples/sincos.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/pbosetti/flotr}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flotr}
  s.rubygems_version = %q{1.2.0}
  s.has_rdoc = true
  s.summary = %q{Flotr (pron. like "plotter") is a Ruby plotter via flot.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<erubis>, [">= 2.6.4"])
    else
      s.add_dependency(%q<erubis>, [">= 2.6.4"])
    end
  else
    s.add_dependency(%q<erubis>, [">= 2.6.4"])
  end
end