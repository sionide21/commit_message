# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = "commit_message"
  spec.version       = "0.0.1"
  spec.authors       = ["Ben Olive"]
  spec.email         = ["ben.olive@salesloft.com"]
  spec.summary       = "Convert a commit message into a reasonable description"
  spec.homepage      = "https://github.com/sionide21/commit_message"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
