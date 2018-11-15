
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "astarisk/version"

Gem::Specification.new do |spec|
  spec.name          = "astarisk"
  spec.version       = Astarisk::VERSION
  spec.authors       = ["TAGOMORI Satoshi"]
  spec.email         = ["tagomoris@gmail.com"]

  spec.summary       = %q{AST visualizer}
  spec.description   = %q{Draw a graph of node tree of RubyVM::AbstractSyntaxTree}
  spec.homepage      = "https://github.com/tagomoris/astarisk"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
end
