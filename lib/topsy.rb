require 'rubygems'

gem 'hashie', '~> 0.1.3'
require 'hashie'

gem 'httparty', '~> 0.4.5'
require 'httparty'

directory = File.expand_path(File.dirname(__FILE__))

Hash.send :include, Hashie::HashExtensions


module Topsy
  class TopsyError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

  class RateLimitExceeded < StandardError; end
  class Unauthorized      < StandardError; end
  class General           < TopsyError; end

  class Unavailable   < StandardError; end
  class InformTopsy < StandardError; end
  class NotFound      < StandardError; end
  
  # Returns profile information for an author (a twitter profile indexed by Topsy). The response contains the name, description (biography) and the influence level of the author
  #
  # @param [String] url URL string for the author.
  # @return [Hashie::Mash]
  def self.author_info(url)
    Topsy::Client.new.author_info(url)
  end
  
  
  # Returns list of authors that talk about the query. The list is sorted by frequency of posts and the influence of authors.
  #
  # @param [String] q the search query string
  # @param [Hash] options method options
  # @option options [String] :window Time window for results. (default: 'a') Options: auto - automatically pick the most recent and relevant window. h last hour, d last day, w last week, m last month, a all time
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Topsy::Page]
  def self.author_search(q, options={})
    result = Topsy::Client.new.author_search(q, options)
    Topsy::Page.new(result, Topsy::Author)
  end
  
  # Returns list of URLs posted by an author
  #
  # @param [String] url URL string for the author.
  # @param [Hash] options method options
  # @option options [String] :contains Query string to filter results
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.link_posts(url, options={})
    Topsy::Client.new.link_posts(url, options={})
  end
  
  # Returns count of links posted by an author. This is the efficient, count-only version of /linkposts
  #
  # @param [String] url URL string for the author.
  # @param [Hash] options method options
  # @option options [String] :contains Query string to filter results
  # @return [Topsy::LinkpostCount]
  def self.link_post_count(url, options={})
    response = Topsy::Client.new.link_post_count(url, options={})
    Topsy::LinkpostCount.new(response)
  end
  
  # Returns list list of author profiles that match the query. The query is matched against the nick, name and biography information and the results are sorted by closeness of match and the influence of authors.
  #
  # @param [String] q the search query string
  # @param [Hash] options method options
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.profile_search(q, options={})
    Topsy::Client.new.profile_search(q, options)
  end
  
  # Returns list of URLs related to a given URL
  #
  # @param [String] url URL string for the author.
  # @param [Hash] options method options
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.related(url, options={})
    Topsy::Client.new.related(url, options)
  end
  
  # Returns list of results for a query.
  #
  # @param [String] q the search query string
  # @param [Hash] options method options
  # @option options [String] :window Time window for results. (default: 'a') Options: auto - automatically pick the most recent and relevant window. h last hour, d last day, w last week, m last month, a all time
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.search(q, options={})
    Topsy::Client.new.search(q, options)
  end
  
  # Returns count of results for a search query.
  #
  # @param [String] q the search query string
  # @return [Topsy::SearchCounts]
  def self.search_count(q)
    Topsy::Client.new.search_count(q)
  end
  
  # Returns counts of tweets for a URL
  #
  # @param [String] url the url to look up
  # @param [Hash] options method options
  # @option options [String] :contains Query string to filter results
  # @return [Hashie::Mash]
  def self.stats(url, options={})
    Topsy::Client.new.stats(url, options)
  end
  
  # Returns list of tags for a URL.
  #
  # @param [String] url the search query string
  # @param [Hash] options method options
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.tags(url, options={})
    Topsy::Client.new.tags(url, options)
  end
  
  # Returns list of tweets (trackbacks) that mention the query URL, most recent first.
  #
  # @param [String] url URL string for the author.
  # @param [Hash] options method options
  # @option options [String] :contains Query string to filter results
  # @option options [Boolean] :infonly filters trackbacks to influential only (default 0)
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.trackbacks(url, options={})
    Topsy::Client.new.trackbacks(url, options)
  end
  
  
  # Returns list of trending terms
  #
  # @param [Hash] options method options
  # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
  # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
  # @return [Hashie::Mash]
  def self.trending(options={})
    Topsy::Client.new.trending(options)
  end
  
  # Returns info about a URL
  #
  # @param [String] url the url to look up
  # @return [Hashie::Mash]
  def self.url_info(url)
    Topsy::Client.new.url_info(url)
  end

  
end

require File.join(directory, 'topsy', 'page')
require File.join(directory, 'topsy', 'linkpost')
require File.join(directory, 'topsy', 'target')
require File.join(directory, 'topsy', 'link_search_result')
require File.join(directory, 'topsy', 'linkpost_count')
require File.join(directory, 'topsy', 'search_counts')
require File.join(directory, 'topsy', 'author')
require File.join(directory, 'topsy', 'client')