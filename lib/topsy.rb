require 'hashie'
require 'httparty'
require 'topsy/configurable'

directory = File.expand_path(File.dirname(__FILE__))
Dir[directory + '/topsy/*.rb'].each{ |f| require f unless f =~ /version/ }

Hash.send :include, Hashie::HashExtensions


module Topsy
  class << self
    include Topsy::Configurable

    def client
      @client = Topsy::Client.new(options) unless defined?(@client)
      @client
    end

    def rate_limit
      self.credit if @rate_limit_info.nil?
      @rate_limit_info
    end
    
    def rate_limit=(info)
      @rate_limit_info = Topsy::RateLimitInfo.new(info)
    end  

    def respond_to_missing?(method_name , include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

private
    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
