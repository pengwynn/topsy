require 'bundler'
require 'bundler/version'
require 'lib/topsy'

Gem::Specification.new do |s|
  s.name = %q{topsy}
  s.version = Topsy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["Wynn Netherland", "Ernesto Tagwerker"]
  s.date = %q{2010-07-27}
  s.description = %q{Wrapper for the Topsy API}
  s.email = %q{wynn.netherland@gmail.com}
  s.files = Dir.glob("{lib}/**/*")
  s.homepage = %q{http://wynnnetherland.com/projects/topsy/}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby wrapper for the Topsy API}
  s.test_files = [
    "test/helper.rb",
     "test/test_topsy.rb"
  ]

  s.add_bundler_dependencies
end
