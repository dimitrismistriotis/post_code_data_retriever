# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'post_code_data_retriever/version'

Gem::Specification.new do |spec|
  spec.name          = "post_code_data_retriever"
  spec.version       = PostCodeDataRetriever::VERSION
  spec.authors       = ["Dimitrios Mistriotis"]
  spec.email         = ["dimitrismistriotis@gmail.com"]
  spec.description   = %q{Retrieves and parses UK Post Code data initially only from uk-postcodes.com}
  spec.summary       = %q{Retrieves and parses UK Post Code data initially only from uk-postcodes.com}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
