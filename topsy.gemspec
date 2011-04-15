require File.expand_path("../lib/topsy/version", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{topsy}
  s.version = Topsy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["Wynn Netherland", "Ernesto Tagwerker"]
  s.date = %q{2011-01-07}
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

  s.add_dependency 'hashie', '~> 0.4.0'
  s.add_dependency 'httparty', '>= 0.4.5'

  s.add_development_dependency 'shoulda', '~> 2.11.3'
  s.add_development_dependency 'mocha', '~> 0.9.10'
  s.add_development_dependency 'fakeweb', '~> 1.3.0'
  s.add_development_dependency 'jnunemaker-matchy', '~> 0.4.0'
  s.add_development_dependency 'redgreen', '~> 1.2.2'
end
