# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "behave"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kristian Mandrup"]
  s.date = "2011-09-22"
  s.description = "Defines a standard way to add behaviors via decorators"
  s.email = "kmandrup@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.textile"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.textile",
    "Rakefile",
    "VERSION",
    "lib/behave.rb",
    "lib/behave/Behavior decorator pattern.textile",
    "lib/behave/behavior.rb",
    "lib/behave/config.rb",
    "lib/behave/config/class_methods.rb",
    "lib/behave/config/schema.rb",
    "lib/behave/config/schema/helpers.rb",
    "lib/behave/decorator.rb",
    "lib/behave/decorator/configuration.rb",
    "lib/behave/loaders.rb",
    "lib/behave/loaders/base_loader.rb",
    "lib/behave/loaders/config_loader.rb",
    "lib/behave/loaders/storage_loader.rb",
    "lib/behave/loaders/strategy_loader.rb",
    "lib/behave/macros.rb",
    "lib/behave/repository.rb",
    "spec/behave/behavior_spec.rb",
    "spec/behave/decorator_spec.rb",
    "spec/behave/macros_spec.rb",
    "spec/behave/repository_spec.rb",
    "spec/behave/spec_helper.rb",
    "spec/behave_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/kristianmandrup/behave"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Standard behavior decorator patter"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<factory_girl>, [">= 0"])
      s.add_runtime_dependency(%q<sugar-high>, [">= 0.6.0"])
      s.add_runtime_dependency(%q<sweetloader>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<require_all>, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<contextualize>, [">= 0.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.6.3"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<factory_girl>, [">= 0"])
      s.add_dependency(%q<sugar-high>, [">= 0.6.0"])
      s.add_dependency(%q<sweetloader>, [">= 0.1.0"])
      s.add_dependency(%q<require_all>, ["~> 1.2.0"])
      s.add_dependency(%q<contextualize>, [">= 0.2.0"])
      s.add_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, [">= 1.6.3"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<factory_girl>, [">= 0"])
    s.add_dependency(%q<sugar-high>, [">= 0.6.0"])
    s.add_dependency(%q<sweetloader>, [">= 0.1.0"])
    s.add_dependency(%q<require_all>, ["~> 1.2.0"])
    s.add_dependency(%q<contextualize>, [">= 0.2.0"])
    s.add_dependency(%q<rspec>, [">= 2.3.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, [">= 1.6.3"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
