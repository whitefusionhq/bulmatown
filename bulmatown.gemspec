# frozen_string_literal: true

require_relative "lib/bulmatown/version"

Gem::Specification.new do |spec|
  spec.name          = "bulmatown"
  spec.version       = Bulmatown::VERSION
  spec.author        = "Jared White"
  spec.email         = "jared@whitefusion.io"
  spec.summary       = "A Bulma CSS starter theme for Bridgetown"
  spec.homepage      = "https://github.com/whitefusionhq/bulmatown"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features|frontend|example)/!) }
  spec.test_files    = spec.files.grep(%r!^spec/!)
  spec.require_paths = ["lib"]
  spec.metadata      = { "yarn-add" => "bulmatown@#{Bulmatown::VERSION}" }

  spec.required_ruby_version = ">= 2.5.0"

  spec.add_dependency "bridgetown", ">= 0.15", "< 2.0"
  spec.add_dependency "bridgetown-quick-search", "~> 1.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.2"
end
