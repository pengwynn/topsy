require 'test/unit'
require 'pathname'
require 'rubygems'
require 'bundler/setup'

require 'fakeweb'
require 'shoulda'
require 'mocha'
require 'matchy'


$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'topsy'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def topsy_url(url)
  url =~ /^http/ ? url : "http://otter.topsy.com#{url}"
end

def stub_get(url, filename, options={})
  opts = {:body => fixture_file(filename)}.merge(options)
  
  headers = {
    'x-ratelimit-remaining' => '9998',
    'x-ratelimit-limit' => '10000',
    'x-ratelimit-reset' => '1262707200'
  }
  
  FakeWeb.register_uri(:get, topsy_url(url), headers.merge(opts))
end

def stub_post(url, filename)
  FakeWeb.register_uri(:post, topsy_url(url), :body => fixture_file(filename))
end

