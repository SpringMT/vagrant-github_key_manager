# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-github_key_manager/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-github_key_manager"
  spec.version       = VagrantPlugins::GithubKeyManager::VERSION
  spec.authors       = ["SpringMT"]
  spec.email         = ["today.is.sky.blue.sky@gamil.com"]
  spec.summary       = %q{vagrant plugin for github key management}
  spec.homepage      = "https://github.com/SpringMT/vagrant-github_key_manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.description = <<description
vagrant plugin for github key management
description

end
