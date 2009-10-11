# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{scissor-echonest}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["youpy"]
  s.date = %q{2009-10-11}
  s.description = %q{Scissor extension to use Echo Nest Developers API}
  s.email = %q{youpy@buycheapviagraonlinenow.com}
  s.extra_rdoc_files = ["README.rdoc", "ChangeLog"]
  s.files = ["README.rdoc", "ChangeLog", "Rakefile", "spec/fixtures", "spec/fixtures/get_beats.xml", "spec/fixtures/get_segments.xml", "spec/fixtures/sample.mp3", "spec/scissor-echonest_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "lib/scissor", "lib/scissor/echonest", "lib/scissor/echonest/chunk_ext.rb", "lib/scissor/echonest.rb"]
  s.homepage = %q{http://scissorechonest.rubyforge.org}
  s.rdoc_options = ["--title", "scissor-echonest documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{scissorechonest}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Scissor extension to use Echo Nest Developers API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<scissor>, [">= 0.0.22"])
      s.add_runtime_dependency(%q<ruby-echonest>, [">= 0.0.6"])
    else
      s.add_dependency(%q<scissor>, [">= 0.0.22"])
      s.add_dependency(%q<ruby-echonest>, [">= 0.0.6"])
    end
  else
    s.add_dependency(%q<scissor>, [">= 0.0.22"])
    s.add_dependency(%q<ruby-echonest>, [">= 0.0.6"])
  end
end
