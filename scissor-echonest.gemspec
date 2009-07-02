# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{scissor-echonest}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["youpy"]
  s.autorequire = %q{}
  s.date = %q{2009-07-02}
  s.description = %q{Scissor extension to use Echo Nest Developers API}
  s.email = %q{youpy@buycheapviagraonlinenow.com}
  s.extra_rdoc_files = ["README.rdoc", "ChangeLog"]
  s.files = ["README.rdoc", "ChangeLog", "Rakefile", "spec/fixtures", "spec/fixtures/get_beats.xml", "spec/fixtures/sample.mp3", "spec/scissor-echonest_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "lib/scissor", "lib/scissor/echonest.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://scissorechonest.rubyforge.org}
  s.rdoc_options = ["--title", "scissor-echonest documentation", "--charset", "utf-8", "--opname", "index.html", "--line-numbers", "--main", "README.rdoc", "--inline-source", "--exclude", "^(examples|extras)/"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{scissorechonest}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Scissor extension to use Echo Nest Developers API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
