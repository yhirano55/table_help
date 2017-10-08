$LOAD_PATH.push File.expand_path("lib", __dir__)

require "table_help/version"

Gem::Specification.new do |s|
  s.name        = "table_help"
  s.version     = TableHelp::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.homepage    = "https://github.com/yhirano55/table_help"
  s.summary     = "Provide helper methods to build collection or resource tables for Rails 5"
  s.description = s.summary
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "railties", ">= 5.0"

  s.add_development_dependency "bundler", "~> 1.15"

  s.files      = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
end
